#create simulator
set ns [new Simulator]
#create trace file
set tracefile [open udp.tr w]
$ns trace-all $tracefile
#create nam file
set namfile [open udp.nam w]
$ns namtrace-all $namfile
#conclude procedure
proc conclude {} {
global ns tracefile namfile
$ns flush-trace 
close $tracefile
close $namfile
exec nam udp.nam &
exit 0
}
#node creation
set n1 [$ns node]
set n2 [$ns node]
#connection
$ns duplex-link $n1 $n2 5Mb 2ms DropTail
#agent creation
set udp [new Agent/UDP]
$ns attach-agent $n1 $udp
set null [new Agent/Null]
$ns attach-agent $n2 $null
$ns connect $udp $null
#generate traffic
set cbrudp [new Application/Traffic/CBR]
$cbrudp attach-agent $udp
#start traffic
$ns at 0.1 "$cbrudp start"
$ns at 4.5 "$cbrudp stop"
$ns at 5.0 "conclude"
$ns run


