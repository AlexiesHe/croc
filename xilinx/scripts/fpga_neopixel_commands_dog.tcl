# this are commands for the neopixel fpga programming

openocd -f xilinx/scripts/openocd.genesys2.tcl 
riscv-1.0 riscv32-unknown-elf-gdb -ex "target extended-remote localhost:3333"

#timing constraint setup (writing to timing registers)
set *0x20001040=64
set *0x20001060=16
set *0x20001080=9
set *0x200010a0=8
set *0x200010c0=17
set *0x200010e0=1000
set *0x20001100=0xFFFFFF

# writing over jtag (only one led possible at the time)

set *0x20001180=1
set *0x20001200=0x64ff00
set *0x20001180=0

set *0x20001180=1
set *0x20001200=0xff32ff
set *0x20001180=0

# dog part 1 animation (writing to memory)
set *0x10004000=0xff32ff
set *0x10004004=0xff32ff
set *0x10004008=0xff32ff
set *0x1000400c=0xff32ff
set *0x10004010=0x64ff00
set *0x10004014=0xff32ff
set *0x10004018=0xff32ff
set *0x1000401c=0xff32ff

set *0x10004020=0xff32ff
set *0x10004024=0xff32ff
set *0x10004028=0xff32ff
set *0x1000402c=0xff32ff
set *0x10004030=0x64ff00
set *0x10004034=0xff32ff
set *0x10004038=0xff32ff
set *0x1000403c=0xff32ff

set *0x10004040=0xff32ff
set *0x10004044=0xff32ff
set *0x10004048=0xff32ff
set *0x1000404c=0xff32ff
set *0x10004050=0x64ff00
set *0x10004054=0x64ff00
set *0x10004058=0xff32ff
set *0x1000405c=0xff32ff

set *0x10004060=0x64ff00
set *0x10004064=0xff32ff
set *0x10004068=0xff32ff
set *0x1000406c=0xff32ff
set *0x10004070=0x64ff00
set *0x10004074=0xff32ff
set *0x10004078=0x64ff00
set *0x1000407c=0x64ff00

set *0x10004080=0x64ff00
set *0x10004084=0xff32ff
set *0x10004088=0xff32ff
set *0x1000408c=0xff32ff
set *0x10004090=0x64ff00
set *0x10004094=0x64ff00
set *0x10004098=0x64ff00
set *0x1000409c=0x64ff00

set *0x100040a0=0xff32ff
set *0x100040a4=0x64ff00
set *0x100040a8=0x64ff00
set *0x100040ac=0x64ff00
set *0x100040b0=0x64ff00
set *0x100040b4=0x64ff00
set *0x100040b8=0xff32ff
set *0x100040bc=0xff32ff

set *0x100040c0=0xff32ff
set *0x100040c4=0x64ff00
set *0x100040c8=0x64ff00
set *0x100040cc=0x64ff00
set *0x100040d0=0x64ff00
set *0x100040d4=0x64ff00
set *0x100040d8=0xff32ff
set *0x100040dc=0xff32ff

set *0x100040e0=0x64ff00
set *0x100040e4=0xff32ff
set *0x100040e8=0x64ff00
set *0x100040ec=0xff32ff
set *0x100040f0=0x64ff00
set *0x100040f4=0xff32ff
set *0x100040f8=0x64ff00
set *0x100040fc=0xff32ff

# dog part 2 animation (writing to memory)
set *0x10004100=0xff32ff
set *0x10004104=0xff32ff
set *0x10004108=0xff32ff
set *0x1000410c=0x64ff00
set *0x10004110=0x64ff00
set *0x10004114=0xff32ff
set *0x10004118=0xff32ff
set *0x1000411c=0xff32ff

set *0x10004120=0xff32ff
set *0x10004124=0xff32ff
set *0x10004128=0xff32ff
set *0x1000412c=0xff32ff
set *0x10004130=0x64ff00
set *0x10004134=0x64ff00
set *0x10004138=0xff32ff
set *0x1000413c=0xff32ff

set *0x10004140=0xff32ff
set *0x10004144=0xff32ff
set *0x10004148=0xff32ff
set *0x1000414c=0xff32ff
set *0x10004150=0x64ff00
set *0x10004154=0xff32ff
set *0x10004158=0x64ff00
set *0x1000415c=0x64ff00

set *0x10004160=0xff32ff
set *0x10004164=0x64ff00
set *0x10004168=0xff32ff
set *0x1000416c=0xff32ff
set *0x10004170=0x64ff00
set *0x10004174=0x64ff00
set *0x10004178=0x64ff00
set *0x1000417c=0x64ff00

set *0x10004180=0xff32ff
set *0x10004184=0x64ff00
set *0x10004188=0xff32ff
set *0x1000418c=0xff32ff
set *0x10004190=0x64ff00
set *0x10004194=0x64ff00
set *0x10004198=0xff32ff
set *0x1000419c=0xff32ff

set *0x100041a0=0xff32ff
set *0x100041a4=0x64ff00
set *0x100041a8=0x64ff00
set *0x100041ac=0x64ff00
set *0x100041b0=0x64ff00
set *0x100041b4=0x64ff00
set *0x100041b8=0xff32ff
set *0x100041bc=0xff32ff

set *0x100041c0=0xff32ff
set *0x100041c4=0x64ff00
set *0x100041c8=0x64ff00
set *0x100041cc=0x64ff00
set *0x100041d0=0x64ff00
set *0x100041d4=0x64ff00
set *0x100041d8=0xff32ff
set *0x100041dc=0xff32ff

set *0x100041e0=0x64ff00
set *0x100041e4=0xff32ff
set *0x100041e8=0x64ff00
set *0x100041ec=0xff32ff
set *0x100041f0=0x64ff00
set *0x100041f4=0xff32ff
set *0x100041f8=0x64ff00
set *0x100041fc=0xff32ff

# dog part 3 animation (writing to memory)
set *0x10004200=0xff32ff
set *0x10004204=0xff32ff
set *0x10004208=0xff32ff
set *0x1000420c=0xff32ff
set *0x10004210=0x64ff00
set *0x10004214=0xff32ff
set *0x10004218=0xff32ff
set *0x1000421c=0xff32ff

set *0x10004220=0xff32ff
set *0x10004224=0xff32ff
set *0x10004228=0xff32ff
set *0x1000422c=0xff32ff
set *0x10004230=0x64ff00
set *0x10004234=0xff32ff
set *0x10004238=0xff32ff
set *0x1000423c=0xff32ff

set *0x10004240=0xff32ff
set *0x10004244=0xff32ff
set *0x10004248=0xff32ff
set *0x1000424c=0xff32ff
set *0x10004250=0x64ff00
set *0x10004254=0x64ff00
set *0x10004258=0xff32ff
set *0x1000425c=0xff32ff

set *0x10004260=0x64ff00
set *0x10004264=0xff32ff
set *0x10004268=0xff32ff
set *0x1000426c=0xff32ff
set *0x10004270=0x64ff00
set *0x10004274=0xff32ff
set *0x10004278=0x64ff00
set *0x1000427c=0x64ff00

set *0x10004280=0x64ff00
set *0x10004284=0xff32ff
set *0x10004288=0xff32ff
set *0x1000428c=0xff32ff
set *0x10004290=0x64ff00
set *0x10004294=0x64ff00
set *0x10004298=0x64ff00
set *0x1000429c=0x64ff00

set *0x100042a0=0xff32ff
set *0x100042a4=0x64ff00
set *0x100042a8=0x64ff00
set *0x100042ac=0x64ff00
set *0x100042b0=0x64ff00
set *0x100042b4=0x64ff00
set *0x100042b8=0xff32ff
set *0x100042bc=0xff32ff

set *0x100042c0=0xff32ff
set *0x100042c4=0x64ff00
set *0x100042c8=0x64ff00
set *0x100042cc=0x64ff00
set *0x100042d0=0x64ff00
set *0x100042d4=0x64ff00
set *0x100042d8=0xff32ff
set *0x100042dc=0xff32ff

set *0x100042e0=0x64ff00
set *0x100042e4=0xff32ff
set *0x100042e8=0x64ff00
set *0x100042ec=0xff32ff
set *0x100042f0=0x64ff00
set *0x100042f4=0xff32ff
set *0x100042f8=0x64ff00
set *0x100042fc=0xff32ff

# dog part 4 animation (writing to memory)
set *0x10004300=0xff32ff
set *0x10004304=0xff32ff
set *0x10004308=0xff32ff
set *0x1000430c=0x64ff00
set *0x10004310=0x64ff00
set *0x10004314=0xff32ff
set *0x10004318=0xff32ff
set *0x1000431c=0xff32ff

set *0x10004320=0xff32ff
set *0x10004324=0xff32ff
set *0x10004328=0xff32ff
set *0x1000432c=0xff32ff
set *0x10004330=0x64ff00
set *0x10004334=0x64ff00
set *0x10004338=0xff32ff
set *0x1000433c=0xff32ff

set *0x10004340=0xff32ff
set *0x10004344=0xff32ff
set *0x10004348=0xff32ff
set *0x1000434c=0xff32ff
set *0x10004350=0x64ff00
set *0x10004354=0xff32ff
set *0x10004358=0x64ff00
set *0x1000435c=0x64ff00

set *0x10004360=0xff32ff
set *0x10004364=0x64ff00
set *0x10004368=0xff32ff
set *0x1000436c=0xff32ff
set *0x10004370=0x64ff00
set *0x10004374=0x64ff00
set *0x10004378=0x64ff00
set *0x1000437c=0x64ff00

set *0x10004380=0xff32ff
set *0x10004384=0x64ff00
set *0x10004388=0xff32ff
set *0x1000438c=0xff32ff
set *0x10004390=0x64ff00
set *0x10004394=0x64ff00
set *0x10004398=0xff32ff
set *0x1000439c=0xff32ff

set *0x100043a0=0xff32ff
set *0x100043a4=0x64ff00
set *0x100043a8=0x64ff00
set *0x100043ac=0x64ff00
set *0x100043b0=0x64ff00
set *0x100043b4=0x64ff00
set *0x100043b8=0xff32ff
set *0x100043bc=0xff32ff

set *0x100043c0=0xff32ff
set *0x100043c4=0x64ff00
set *0x100043c8=0x64ff00
set *0x100043cc=0x64ff00
set *0x100043d0=0x64ff00
set *0x100043d4=0x64ff00
set *0x100043d8=0xff32ff
set *0x100043dc=0xff32ff

set *0x100043e0=0x64ff00
set *0x100043e4=0xff32ff
set *0x100043e8=0x64ff00
set *0x100043ec=0xff32ff
set *0x100043f0=0x64ff00
set *0x100043f4=0xff32ff
set *0x100043f8=0x64ff00
set *0x100043fc=0xff32ff

# dog part 5 animation (writing to memory)
set *0x10004200=0xff32ff
set *0x10004204=0xff32ff
set *0x10004208=0xff32ff
set *0x1000420c=0xff32ff
set *0x10004210=0x64ff00
set *0x10004214=0xff32ff
set *0x10004218=0xff32ff
set *0x1000421c=0xff32ff

set *0x10004220=0xff32ff
set *0x10004224=0xff32ff
set *0x10004228=0xff32ff
set *0x1000422c=0xff32ff
set *0x10004230=0x64ff00
set *0x10004234=0xff32ff
set *0x10004238=0xff32ff
set *0x1000423c=0xff32ff

set *0x10004240=0xff32ff
set *0x10004244=0xff32ff
set *0x10004248=0xff32ff
set *0x1000424c=0xff32ff
set *0x10004250=0x64ff00
set *0x10004254=0x64ff00
set *0x10004258=0xff32ff
set *0x1000425c=0xff32ff

set *0x10004260=0x64ff00
set *0x10004264=0xff32ff
set *0x10004268=0xff32ff
set *0x1000426c=0xff32ff
set *0x10004270=0x64ff00
set *0x10004274=0xff32ff
set *0x10004278=0x64ff00
set *0x1000427c=0x64ff00

set *0x10004280=0x64ff00
set *0x10004284=0xff32ff
set *0x10004288=0xff32ff
set *0x1000428c=0xff32ff
set *0x10004290=0x64ff00
set *0x10004294=0x64ff00
set *0x10004298=0x64ff00
set *0x1000429c=0x64ff00

set *0x100042a0=0xff32ff
set *0x100042a4=0x64ff00
set *0x100042a8=0x64ff00
set *0x100042ac=0x64ff00
set *0x100042b0=0x64ff00
set *0x100042b4=0x64ff00
set *0x100042b8=0xff32ff
set *0x100042bc=0xff32ff

set *0x100042c0=0xff32ff
set *0x100042c4=0x64ff00
set *0x100042c8=0x64ff00
set *0x100042cc=0x64ff00
set *0x100042d0=0x64ff00
set *0x100042d4=0x64ff00
set *0x100042d8=0xff32ff
set *0x100042dc=0xff32ff

set *0x100042e0=0x64ff00
set *0x100042e4=0xff32ff
set *0x100042e8=0x64ff00
set *0x100042ec=0xff32ff
set *0x100042f0=0x64ff00
set *0x100042f4=0xff32ff
set *0x100042f8=0x64ff00
set *0x100042fc=0xff32ff

# dog part 6 animation (writing to memory)
set *0x10004300=0xff32ff
set *0x10004304=0xff32ff
set *0x10004308=0xff32ff
set *0x1000430c=0x64ff00
set *0x10004310=0x64ff00
set *0x10004314=0xff32ff
set *0x10004318=0xff32ff
set *0x1000431c=0xff32ff

set *0x10004320=0xff32ff
set *0x10004324=0xff32ff
set *0x10004328=0xff32ff
set *0x1000432c=0xff32ff
set *0x10004330=0x64ff00
set *0x10004334=0x64ff00
set *0x10004338=0xff32ff
set *0x1000433c=0xff32ff

set *0x10004340=0xff32ff
set *0x10004344=0xff32ff
set *0x10004348=0xff32ff
set *0x1000434c=0xff32ff
set *0x10004350=0x64ff00
set *0x10004354=0xff32ff
set *0x10004358=0x64ff00
set *0x1000435c=0x64ff00

set *0x10004360=0xff32ff
set *0x10004364=0x64ff00
set *0x10004368=0xff32ff
set *0x1000436c=0xff32ff
set *0x10004370=0x64ff00
set *0x10004374=0x64ff00
set *0x10004378=0x64ff00
set *0x1000437c=0x64ff00

set *0x10004380=0xff32ff
set *0x10004384=0x64ff00
set *0x10004388=0xff32ff
set *0x1000438c=0xff32ff
set *0x10004390=0x64ff00
set *0x10004394=0x64ff00
set *0x10004398=0xff32ff
set *0x1000439c=0xff32ff

set *0x100043a0=0xff32ff
set *0x100043a4=0x64ff00
set *0x100043a8=0x64ff00
set *0x100043ac=0x64ff00
set *0x100043b0=0x64ff00
set *0x100043b4=0x64ff00
set *0x100043b8=0xff32ff
set *0x100043bc=0xff32ff

set *0x100043c0=0xff32ff
set *0x100043c4=0x64ff00
set *0x100043c8=0x64ff00
set *0x100043cc=0x64ff00
set *0x100043d0=0x64ff00
set *0x100043d4=0x64ff00
set *0x100043d8=0xff32ff
set *0x100043dc=0xff32ff

set *0x100043e0=0x64ff00
set *0x100043e4=0xff32ff
set *0x100043e8=0x64ff00
set *0x100043ec=0xff32ff
set *0x100043f0=0x64ff00
set *0x100043f4=0xff32ff
set *0x100043f8=0x64ff00
set *0x100043fc=0xff32ff

# dog part 7 animation (writing to memory)
set *0x10004400=0xff32ff
set *0x10004404=0xff32ff
set *0x10004408=0xff32ff
set *0x1000440c=0xff32ff
set *0x10004410=0x64ff00
set *0x10004414=0xff32ff
set *0x10004418=0xff32ff
set *0x1000441c=0xff32ff

set *0x10004420=0xff32ff
set *0x10004424=0xff32ff
set *0x10004428=0xff32ff
set *0x1000442c=0xff32ff
set *0x10004430=0x64ff00
set *0x10004434=0xff32ff
set *0x10004438=0xff32ff
set *0x1000443c=0xff32ff

set *0x10004440=0xff32ff
set *0x10004444=0xff32ff
set *0x10004448=0xff32ff
set *0x1000444c=0xff32ff
set *0x10004450=0x64ff00
set *0x10004454=0x64ff00
set *0x10004458=0xff32ff
set *0x1000445c=0xff32ff

set *0x10004460=0x64ff00
set *0x10004464=0xff32ff
set *0x10004468=0xff32ff
set *0x1000446c=0xff32ff
set *0x10004470=0x64ff00
set *0x10004474=0xff32ff
set *0x10004478=0x64ff00
set *0x1000447c=0x64ff00

set *0x10004480=0x64ff00
set *0x10004484=0xff32ff
set *0x10004488=0xff32ff
set *0x1000448c=0xff32ff
set *0x10004490=0x64ff00
set *0x10004494=0x64ff00
set *0x10004498=0x64ff00
set *0x1000449c=0x64ff00

set *0x100044a0=0xff32ff
set *0x100044a4=0x64ff00
set *0x100044a8=0x64ff00
set *0x100044ac=0x64ff00
set *0x100044b0=0x64ff00
set *0x100044b4=0x64ff00
set *0x100044b8=0xff32ff
set *0x100044bc=0xff32ff

set *0x100044c0=0xff32ff
set *0x100044c4=0x64ff00
set *0x100044c8=0x64ff00
set *0x100044cc=0x64ff00
set *0x100044d0=0x64ff00
set *0x100044d4=0x64ff00
set *0x100044d8=0xff32ff
set *0x100044dc=0xff32ff

set *0x100044e0=0x64ff00
set *0x100044e4=0xff32ff
set *0x100044e8=0x64ff00
set *0x100044ec=0xff32ff
set *0x100044f0=0x64ff00
set *0x100044f4=0xff32ff
set *0x100044f8=0x64ff00
set *0x100044fc=0xff32ff

# dog part 8 animation (writing to memory)
set *0x10004500=0xff32ff
set *0x10004504=0xff32ff
set *0x10004508=0xff32ff
set *0x1000450c=0x64ff00
set *0x10004510=0x64ff00
set *0x10004514=0xff32ff
set *0x10004518=0xff32ff
set *0x1000451c=0xff32ff

set *0x10004520=0xff32ff
set *0x10004524=0xff32ff
set *0x10004528=0xff32ff
set *0x1000452c=0xff32ff
set *0x10004530=0x64ff00
set *0x10004534=0x64ff00
set *0x10004538=0xff32ff
set *0x1000453c=0xff32ff

set *0x10004540=0xff32ff
set *0x10004544=0xff32ff
set *0x10004548=0xff32ff
set *0x1000454c=0xff32ff
set *0x10004550=0x64ff00
set *0x10004554=0xff32ff
set *0x10004558=0x64ff00
set *0x1000455c=0x64ff00

set *0x10004560=0xff32ff
set *0x10004564=0x64ff00
set *0x10004568=0xff32ff
set *0x1000456c=0xff32ff
set *0x10004570=0x64ff00
set *0x10004574=0x64ff00
set *0x10004578=0x64ff00
set *0x1000457c=0x64ff00

set *0x10004580=0xff32ff
set *0x10004584=0x64ff00
set *0x10004588=0xff32ff
set *0x1000458c=0xff32ff
set *0x10004590=0x64ff00
set *0x10004594=0x64ff00
set *0x10004598=0xff32ff
set *0x1000459c=0xff32ff

set *0x100045a0=0xff32ff
set *0x100045a4=0x64ff00
set *0x100045a8=0x64ff00
set *0x100045ac=0x64ff00
set *0x100045b0=0x64ff00
set *0x100045b4=0x64ff00
set *0x100045b8=0xff32ff
set *0x100045bc=0xff32ff

set *0x100045c0=0xff32ff
set *0x100045c4=0x64ff00
set *0x100045c8=0x64ff00
set *0x100045cc=0x64ff00
set *0x100045d0=0x64ff00
set *0x100045d4=0x64ff00
set *0x100045d8=0xff32ff
set *0x100045dc=0xff32ff

set *0x100045e0=0x64ff00
set *0x100045e4=0xff32ff
set *0x100045e8=0x64ff00
set *0x100045ec=0xff32ff
set *0x100045f0=0x64ff00
set *0x100045f4=0xff32ff
set *0x100045f8=0x64ff00
set *0x100045fc=0xff32ff

# dog part 9 animation (writing to memory)
set *0x10004600=0xff32ff
set *0x10004604=0xff32ff
set *0x10004608=0xff32ff
set *0x1000460c=0xff32ff
set *0x10004610=0x64ff00
set *0x10004614=0xff32ff
set *0x10004618=0xff32ff
set *0x1000461c=0xff32ff

set *0x10004620=0xff32ff
set *0x10004624=0xff32ff
set *0x10004628=0xff32ff
set *0x1000462c=0xff32ff
set *0x10004630=0x64ff00
set *0x10004634=0xff32ff
set *0x10004638=0xff32ff
set *0x1000463c=0xff32ff

set *0x10004640=0xff32ff
set *0x10004644=0xff32ff
set *0x10004648=0xff32ff
set *0x1000464c=0xff32ff
set *0x10004650=0x64ff00
set *0x10004654=0x64ff00
set *0x10004658=0xff32ff
set *0x1000465c=0xff32ff

set *0x10004660=0x64ff00
set *0x10004664=0xff32ff
set *0x10004668=0xff32ff
set *0x1000466c=0xff32ff
set *0x10004670=0x64ff00
set *0x10004674=0xff32ff
set *0x10004678=0x64ff00
set *0x1000467c=0x64ff00

set *0x10004680=0x64ff00
set *0x10004684=0xff32ff
set *0x10004688=0xff32ff
set *0x1000468c=0xff32ff
set *0x10004690=0x64ff00
set *0x10004694=0x64ff00
set *0x10004698=0x64ff00
set *0x1000469c=0x64ff00

set *0x100046a0=0xff32ff
set *0x100046a4=0x64ff00
set *0x100046a8=0x64ff00
set *0x100046ac=0x64ff00
set *0x100046b0=0x64ff00
set *0x100046b4=0x64ff00
set *0x100046b8=0xff32ff
set *0x100046bc=0xff32ff

set *0x100046c0=0xff32ff
set *0x100046c4=0x64ff00
set *0x100046c8=0x64ff00
set *0x100046cc=0x64ff00
set *0x100046d0=0x64ff00
set *0x100046d4=0x64ff00
set *0x100046d8=0xff32ff
set *0x100046dc=0xff32ff

set *0x100046e0=0x64ff00
set *0x100046e4=0xff32ff
set *0x100046e8=0x64ff00
set *0x100046ec=0xff32ff
set *0x100046f0=0x64ff00
set *0x100046f4=0xff32ff
set *0x100046f8=0x64ff00
set *0x100046fc=0xff32ff

# dog part 10 animation (writing to memory)
set *0x10004700=0xff32ff
set *0x10004704=0xff32ff
set *0x10004708=0xff32ff
set *0x1000470c=0x64ff00
set *0x10004710=0x64ff00
set *0x10004714=0xff32ff
set *0x10004718=0xff32ff
set *0x1000471c=0xff32ff

set *0x10004720=0xff32ff
set *0x10004724=0xff32ff
set *0x10004728=0xff32ff
set *0x1000472c=0xff32ff
set *0x10004730=0x64ff00
set *0x10004734=0x64ff00
set *0x10004738=0xff32ff
set *0x1000473c=0xff32ff

set *0x10004740=0xff32ff
set *0x10004744=0xff32ff
set *0x10004748=0xff32ff
set *0x1000474c=0xff32ff
set *0x10004750=0x64ff00
set *0x10004754=0xff32ff
set *0x10004758=0x64ff00
set *0x1000475c=0x64ff00

set *0x10004760=0xff32ff
set *0x10004764=0x64ff00
set *0x10004768=0xff32ff
set *0x1000476c=0xff32ff
set *0x10004770=0x64ff00
set *0x10004774=0x64ff00
set *0x10004778=0x64ff00
set *0x1000477c=0x64ff00

set *0x10004780=0xff32ff
set *0x10004784=0x64ff00
set *0x10004788=0xff32ff
set *0x1000478c=0xff32ff
set *0x10004790=0x64ff00
set *0x10004794=0x64ff00
set *0x10004798=0xff32ff
set *0x1000479c=0xff32ff

set *0x100047a0=0xff32ff
set *0x100047a4=0x64ff00
set *0x100047a8=0x64ff00
set *0x100047ac=0x64ff00
set *0x100047b0=0x64ff00
set *0x100047b4=0x64ff00
set *0x100047b8=0xff32ff
set *0x100047bc=0xff32ff

set *0x100047c0=0xff32ff
set *0x100047c4=0x64ff00
set *0x100047c8=0x64ff00
set *0x100047cc=0x64ff00
set *0x100047d0=0x64ff00
set *0x100047d4=0x64ff00
set *0x100047d8=0xff32ff
set *0x100047dc=0xff32ff

set *0x100047e0=0x64ff00
set *0x100047e4=0xff32ff
set *0x100047e8=0x64ff00
set *0x100047ec=0xff32ff
set *0x100047f0=0x64ff00
set *0x100047f4=0xff32ff
set *0x100047f8=0x64ff00
set *0x100047fc=0xff32ff


python import time; time.sleep(1)
set *0x20001180=2
set *0x20001120=0x10004000
set *0x20001140=2560
set *0x20001160=1
set *0x20001160=0
