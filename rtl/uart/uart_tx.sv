`include "common_cells/registers.svh"

module uart_tx #() 
(
  input logic  clk_i,
  input logic  rst_ni,

  input logic  baud_rate_edge,
  input logic  double_rate_edge,

  output logic txd,

  input uart_pkg::reg_read_t      reg_read,
  output uart_pkg::tx_reg_write_t reg_write
);

  // Import the UART package for definitions and parameters
  import uart_pkg::*;

  ////////////////////////////////////////////////////////////////////////////////////////////////
  // Instantiations //
  ////////////////////////////////////////////////////////////////////////////////////////////////

  //--FIFO----------------------------------------------------------------------------------------
  logic fifo_clear;
  logic fifo_full;
  logic fifo_empty;
  logic [7:0] fifo_data_i;
  logic [7:0] fifo_data_o;
  logic fifo_push;
  logic fifo_pop;
  logic [3:0] fifo_usage;

  //--THR-Full------------------------------------------------------------------------------------
  logic thr_full_q, thr_full_d;

  //--Statemachine-Transition-Signals-------------------------------------------------------------
  state_type_tx state_q, state_d;

  logic [2:0] word_len_bits;
  logic [7:0] word_len_mask;

  //--Statemachine-TSR-Signals--------------------------------------------------------------------
  logic tsr_empty;
  logic tsr_finish;
  logic [7:0] tsr_q, tsr_d;
  logic [2:0] tsr_count_q, tsr_count_d;

  logic txd_q, txd_d;

  ////////////////////////////////////////////////////////////////////////////////////////////////
  // FIFO Instantiation //
  ////////////////////////////////////////////////////////////////////////////////////////////////

  fifo_v3 # (
    .FALL_THROUGH(),   
    .DATA_WIDTH  (8), 
    .DEPTH       (16), 
    .dtype       (),
    .ADDR_DEPTH  () // DO NOT OVERWRITE THIS PARAMETER
  ) i_fifo_v3 (
    .clk_i,                   // Clock
    .rst_ni,                  // Asynchronous reset active low
    .flush_i   (fifo_clear),  // flush the queue
    .testmode_i(1'b0      ),       
    // status flags
    .full_o    (fifo_full),   // queue is full
    .empty_o   (fifo_empty),  // queue is empty
    .usage_o   (fifo_usage),  // fill pointer
    // as long as the queue is not full we can push new data
    .data_i    (fifo_data_i), // data to push into the queue
    .push_i    (fifo_push  ), // data is valid and can be pushed to the queue
    // as long as the queue is not empty we can pop new elements
    .data_o    (fifo_data_o), // output data
    .pop_i     (fifo_pop   )  // pop head from queue
  );
  
  ////////////////////////////////////////////////////////////////////////////////////////////////
  // General Logic //
  ////////////////////////////////////////////////////////////////////////////////////////////////
  always_comb begin
    //--------------------------------------------------------------------------------------------
    // Defaults
    //--------------------------------------------------------------------------------------------
    thr_full_d    = thr_full_q;
    word_len_mask = '0;

    //--FIFO Combinational------------------------------------------------------------------------
    fifo_clear  = 1'b0;
    fifo_push   = 1'b0;
    fifo_data_i = '0;

    //--Register Interface------------------------------------------------------------------------
    reg_write.fcr_tx_valid     = 1'b0;
    reg_write.fcr_tx_fifo_rst  = 1'b0;

    reg_write.lsr_valid     = 2'b00;
    reg_write.lsr_thr_empty = 1'b0;
    reg_write.lsr_tx_empty  = 1'b0;

    //--Statemachine Combinational----------------------------------------------------------------
    state_d       = state_q;     // Pass along state

    txd           = txd_q & ~reg_read.lcr.strct.set_break; // UART Output Assignment
    txd_d         = txd_q;       // UART Output store for one bit time

    fifo_pop      = 1'b0;        // Read and Remove Byte From FIFO

    tsr_d         = tsr_q;       //TSR
    tsr_count_d   = tsr_count_q; //TSR
    tsr_finish    = 1'b0;        //TSR
    tsr_empty     = 1'b0;        //TSR

    //--------------------------------------------------------------------------------------------
    // Word Length 
    //--------------------------------------------------------------------------------------------
    case (reg_read.lcr.strct.word_len)
      2'b00: word_len_bits = 3'b100; // 5 Bits (4th index in tsr)
      2'b01: word_len_bits = 3'b101; // 6 Bits (5th index in tsr)
      2'b10: word_len_bits = 3'b110; // 7 Bits (6th index in tsr)
      2'b11: word_len_bits = 3'b111; // 8 Bits (7th index in tsr)
      default: word_len_bits = 3'b111; 
    endcase

    for (int i = 0; i <= word_len_bits; i = i + 1) begin
      word_len_mask[i] = 1'b1;
    end

    //--------------------------------------------------------------------------------------------
    // THR Full Flag
    //--------------------------------------------------------------------------------------------
    if (reg_read.obi_write_thr) begin
      thr_full_d = 1'b1;
    end

    //--------------------------------------------------------------------------------------------
    // Reset LSR
    //--------------------------------------------------------------------------------------------
    if (reg_read.obi_write_thr) begin
      reg_write.lsr_valid     = 2'b11;
      reg_write.lsr_thr_empty = 1'b0;
      reg_write.lsr_tx_empty  = 1'b0;
    end

  ////////////////////////////////////////////////////////////////////////////////////////////////
  // Statemachine Combinational //
  ////////////////////////////////////////////////////////////////////////////////////////////////

    //--------------------------------------------------------------------------------------------
    // TSR - Transmitter Shift Register (parallel to serial)
    //--------------------------------------------------------------------------------------------
    if (state_q == TXDATA & (tsr_count_q <= word_len_bits)) begin
      txd_d       = tsr_q[tsr_count_q]; //TODO ?
      if (baud_rate_edge) begin
        //txd_d       = tsr_q[tsr_count_q]; //TODO ?
        tsr_count_d = tsr_count_q + 1;
        tsr_finish  = (tsr_count_q == word_len_bits)? 1'b1 : 1'b0;
      end
    end

    //--------------------------------------------------------------------------------------------
    // State Transition
    //--------------------------------------------------------------------------------------------
    case(state_q)
      TXIDLE: begin
        txd_d       = 1'b1; // Inactive High
        tsr_d       = '0;
        tsr_count_d = 1'b0;
        tsr_empty   = 1'b1;
        
        if (reg_read.fcr.strct.fifo_en) begin
          if (~fifo_empty & baud_rate_edge) begin // Read FIFO into TSR
            tsr_d    = fifo_data_o;
            fifo_pop = 1'b1;
            state_d  = TXSTART;
          end
        end else begin
          if (thr_full_q & baud_rate_edge) begin // Read THR into TSR
            tsr_d      = reg_read.thr.strct.char_tx & word_len_mask;
            thr_full_d = 1'b0;
            state_d    = TXSTART;
          end
        end
      end

      TXSTART: begin
        txd_d   = 1'b0; 
        if (baud_rate_edge) begin
          state_d = TXDATA;
        end
      end

      TXDATA: begin
        if (tsr_finish) begin
          if (reg_read.lcr.strct.par_en) begin
            state_d = TXPAR;
          end else begin
            state_d = TXSTOP1;
          end
        end
      end

      TXPAR: begin
        case (reg_read.lcr.arr[5:4])// Read Parity Configuration 
          3'b00: txd_d = ~(^tsr_q); // Odd Parity
          3'b01: txd_d = ^tsr_q;    // Even Parity
          3'b10: txd_d = 1'b1;      // Forced 1
          3'b11: txd_d = 1'b0;      // Forced 0
          default: txd_d = 1'b0;
        endcase
        if (baud_rate_edge) begin
          state_d = TXSTOP1;
        end
      end

      TXSTOP1: begin
        txd_d   = 1'b1; 
        if (baud_rate_edge) begin
          if (reg_read.lcr.strct.stop_bits) begin
            state_d = TXSTOP2;
          end else begin
            if (reg_read.fcr.strct.fifo_en) begin
              if (~fifo_empty) begin // Read FIFO into TSR
                tsr_count_d = 1'b0;
                tsr_d    = fifo_data_o;
                fifo_pop = 1'b1;
                state_d  = TXSTART;
              end else begin
                state_d = TXIDLE;
              end
            end else begin
              if (thr_full_q) begin // Read THR into TSR
                tsr_count_d = 1'b0;
                tsr_d      = reg_read.thr.strct.char_tx & word_len_mask;
                thr_full_d = 1'b0;
                state_d    = TXSTART;
              end else begin
                state_d = TXIDLE;
              end
            end
          end
        end
      end

      TXSTOP2: begin
        if (word_len_bits == 3'b100) begin

          if(double_rate_edge) begin
            if (reg_read.fcr.strct.fifo_en) begin
              if (~fifo_empty) begin // Read FIFO into TSR
                tsr_count_d = 1'b0;
                tsr_d    = fifo_data_o;
                fifo_pop = 1'b1;
                state_d  = TXWAIT;
              end else begin
                state_d = TXIDLE;
              end
            end else begin
              if (thr_full_q) begin // Read THR into TSR
                tsr_count_d = 1'b0;
                tsr_d      = reg_read.thr.strct.char_tx & word_len_mask;
                thr_full_d = 1'b0;
                state_d    = TXSTART;
              end else begin
                state_d = TXIDLE;
              end
            end
          end

        end else begin

          if(baud_rate_edge) begin
            if (reg_read.fcr.strct.fifo_en) begin
              if (~fifo_empty) begin // Read FIFO into TSR
                tsr_count_d = 1'b0;
                tsr_d    = fifo_data_o;
                fifo_pop = 1'b1;
                state_d  = TXSTART;
              end else begin
                state_d = TXIDLE;
              end
            end else begin
              if (thr_full_q) begin // Read THR into TSR
                tsr_count_d = 1'b0;
                tsr_d      = reg_read.thr.strct.char_tx & word_len_mask;
                thr_full_d = 1'b0;
                state_d    = TXSTART;
              end else begin
                state_d = TXIDLE;
              end
            end
          end

        end
      end

      TXWAIT: begin // Wait here for a half Baudrate Cycle
        if (baud_rate_edge) begin
          state_d  = TXSTART;
        end 
      end

      default: state_d = TXIDLE;
    endcase

  ////////////////////////////////////////////////////////////////////////////////////////////////
  // FIFO Combinational //
  ////////////////////////////////////////////////////////////////////////////////////////////////

    if (reg_read.fcr.strct.fifo_en) begin
      //--Reset-FIFO------------------------------------------------------------------------------
      fifo_clear = 1'b0;

      if (reg_read.fcr.strct.tx_fifo_rst) begin
        fifo_clear = 1'b1;
        reg_write.fcr_tx_fifo_rst = 1'b0; 
        reg_write.fcr_tx_valid    = 1'b1;
      end 

      //--Set-LSR---------------------------------------------------------------------------------
      if (~thr_full_q) begin // TODO >?< 
        reg_write.lsr_thr_empty = 1'b1;
        reg_write.lsr_valid[0]  = 1'b1;
        if (fifo_empty & tsr_empty) begin
          reg_write.lsr_tx_empty = 1'b1;
          reg_write.lsr_valid[1] = 1'b1;
        end
      end

      //--Write-FIFO-from-THR---------------------------------------------------------------------
      if (thr_full_q & (~fifo_full)) begin
        fifo_push   = 1'b1;
        fifo_data_i = reg_read.thr.strct.char_tx & word_len_mask;
        thr_full_d  = 1'b0;
      end
    end

  ////////////////////////////////////////////////////////////////////////////////////////////////
  // THR Combinational //
  ////////////////////////////////////////////////////////////////////////////////////////////////

    if (~reg_read.fcr.strct.fifo_en) begin
      //--Keep-FIFO-cleared-----------------------------------------------------------------------
      fifo_clear = 1'b1;
      //--Set-LSR---------------------------------------------------------------------------------
      if (~thr_full_q) begin
        reg_write.lsr_thr_empty = 1'b1;
        reg_write.lsr_valid[0]  = 1'b1;
        if (tsr_empty) begin
          reg_write.lsr_tx_empty = 1'b1;
          reg_write.lsr_valid[1] = 1'b1;
        end
      end
    end

  end

  ////////////////////////////////////////////////////////////////////////////////////////////////
  // Sequential //
  ////////////////////////////////////////////////////////////////////////////////////////////////

  `FF(thr_full_q, thr_full_d, '0, clk_i, rst_ni)

  `FF(tsr_q, tsr_d, '0, clk_i, rst_ni)
  `FF(tsr_count_q, tsr_count_d, '0, clk_i, rst_ni)

  `FF(txd_q, txd_d, '1, clk_i, rst_ni)

  `FF(state_q, state_d, TXIDLE, clk_i, rst_ni)

endmodule
