onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /instructionFetch/clock
add wave -noupdate /instructionFetch/reset
add wave -noupdate /instructionFetch/jumpAddress
add wave -noupdate /instructionFetch/jumpEnable
add wave -noupdate -radix unsigned /instructionFetch/Daddress
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {431 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 204
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {852 ps}
view wave 
wave clipboard store
wave create -driver freeze -pattern clock -initialvalue HiZ -period 100ps -dutycycle 50 -starttime 0ps -endtime 1000ps sim:/instructionFetch/clock 
wave create -driver freeze -pattern constant -value 0 -starttime 0ps -endtime 1000ps sim:/instructionFetch/reset 
wave create -driver freeze -pattern random -initialvalue zzzzzzzzzzzzzzzz -period 50ps -random_type Uniform -seed 5 -range 15 0 -starttime 0ps -endtime 1000ps sim:/instructionFetch/jumpAddress 
WaveExpandAll -1
wave create -driver freeze -pattern constant -value 0 -starttime 0ps -endtime 1000ps sim:/instructionFetch/jumpEnable 
wave modify -driver freeze -pattern constant -value 1 -starttime 90ps -endtime 100ps Edit:/instructionFetch/reset 
wave modify -driver freeze -pattern constant -value St1 -starttime 90ps -endtime 101ps Edit:/instructionFetch/reset 
wave modify -driver freeze -pattern constant -value 1 -starttime 399ps -endtime 401ps Edit:/instructionFetch/jumpEnable 
wave modify -driver freeze -pattern constant -value 0 -range 15 0 -starttime 399ps -endtime 401ps Edit:/instructionFetch/jumpAddress 
wave modify -driver freeze -pattern constant -value 0000000000000000 -range 15 0 -starttime 0ps -endtime 1000ps Edit:/instructionFetch/jumpAddress 
WaveCollapseAll -1
wave clipboard restore
