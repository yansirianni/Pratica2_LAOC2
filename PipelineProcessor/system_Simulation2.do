onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system/Clock
add wave -noupdate /system/Reset
add wave -noupdate /system/q
add wave -noupdate -radix unsigned /system/proc1/rf/RegReadAddress1
add wave -noupdate -radix unsigned /system/proc1/rf/RegReadAddress2
add wave -noupdate -radix unsigned /system/proc1/rf/RegWriteAdress
add wave -noupdate -radix unsigned -childformat {{{/system/proc1/rf/WriteData[19]} -radix unsigned} {{/system/proc1/rf/WriteData[18]} -radix unsigned} {{/system/proc1/rf/WriteData[17]} -radix unsigned} {{/system/proc1/rf/WriteData[16]} -radix unsigned} {{/system/proc1/rf/WriteData[15]} -radix unsigned} {{/system/proc1/rf/WriteData[14]} -radix unsigned} {{/system/proc1/rf/WriteData[13]} -radix unsigned} {{/system/proc1/rf/WriteData[12]} -radix unsigned} {{/system/proc1/rf/WriteData[11]} -radix unsigned} {{/system/proc1/rf/WriteData[10]} -radix unsigned} {{/system/proc1/rf/WriteData[9]} -radix unsigned} {{/system/proc1/rf/WriteData[8]} -radix unsigned} {{/system/proc1/rf/WriteData[7]} -radix unsigned} {{/system/proc1/rf/WriteData[6]} -radix unsigned} {{/system/proc1/rf/WriteData[5]} -radix unsigned} {{/system/proc1/rf/WriteData[4]} -radix unsigned} {{/system/proc1/rf/WriteData[3]} -radix unsigned} {{/system/proc1/rf/WriteData[2]} -radix unsigned} {{/system/proc1/rf/WriteData[1]} -radix unsigned} {{/system/proc1/rf/WriteData[0]} -radix unsigned}} -subitemconfig {{/system/proc1/rf/WriteData[19]} {-height 15 -radix unsigned} {/system/proc1/rf/WriteData[18]} {-height 15 -radix unsigned} {/system/proc1/rf/WriteData[17]} {-height 15 -radix unsigned} {/system/proc1/rf/WriteData[16]} {-height 15 -radix unsigned} {/system/proc1/rf/WriteData[15]} {-height 15 -radix unsigned} {/system/proc1/rf/WriteData[14]} {-height 15 -radix unsigned} {/system/proc1/rf/WriteData[13]} {-height 15 -radix unsigned} {/system/proc1/rf/WriteData[12]} {-height 15 -radix unsigned} {/system/proc1/rf/WriteData[11]} {-height 15 -radix unsigned} {/system/proc1/rf/WriteData[10]} {-height 15 -radix unsigned} {/system/proc1/rf/WriteData[9]} {-height 15 -radix unsigned} {/system/proc1/rf/WriteData[8]} {-height 15 -radix unsigned} {/system/proc1/rf/WriteData[7]} {-height 15 -radix unsigned} {/system/proc1/rf/WriteData[6]} {-height 15 -radix unsigned} {/system/proc1/rf/WriteData[5]} {-height 15 -radix unsigned} {/system/proc1/rf/WriteData[4]} {-height 15 -radix unsigned} {/system/proc1/rf/WriteData[3]} {-height 15 -radix unsigned} {/system/proc1/rf/WriteData[2]} {-height 15 -radix unsigned} {/system/proc1/rf/WriteData[1]} {-height 15 -radix unsigned} {/system/proc1/rf/WriteData[0]} {-height 15 -radix unsigned}} /system/proc1/rf/WriteData
add wave -noupdate -format Literal -radix unsigned /system/proc1/rf/WriteEnable
add wave -noupdate -radix unsigned /system/proc1/rf/clock
add wave -noupdate -radix unsigned /system/proc1/rf/DataOut1
add wave -noupdate -radix unsigned /system/proc1/rf/DataOut2
add wave -noupdate -radix unsigned /system/proc1/rf/decOut
add wave -noupdate -radix unsigned -childformat {{{/system/proc1/rf/register[15]} -radix unsigned} {{/system/proc1/rf/register[14]} -radix unsigned} {{/system/proc1/rf/register[13]} -radix unsigned} {{/system/proc1/rf/register[12]} -radix unsigned} {{/system/proc1/rf/register[11]} -radix unsigned} {{/system/proc1/rf/register[10]} -radix unsigned} {{/system/proc1/rf/register[9]} -radix unsigned} {{/system/proc1/rf/register[8]} -radix unsigned} {{/system/proc1/rf/register[7]} -radix unsigned} {{/system/proc1/rf/register[6]} -radix unsigned} {{/system/proc1/rf/register[5]} -radix unsigned} {{/system/proc1/rf/register[4]} -radix unsigned} {{/system/proc1/rf/register[3]} -radix unsigned} {{/system/proc1/rf/register[2]} -radix unsigned -childformat {{{/system/proc1/rf/register[2][19]} -radix unsigned} {{/system/proc1/rf/register[2][18]} -radix unsigned} {{/system/proc1/rf/register[2][17]} -radix unsigned} {{/system/proc1/rf/register[2][16]} -radix unsigned} {{/system/proc1/rf/register[2][15]} -radix unsigned} {{/system/proc1/rf/register[2][14]} -radix unsigned} {{/system/proc1/rf/register[2][13]} -radix unsigned} {{/system/proc1/rf/register[2][12]} -radix unsigned} {{/system/proc1/rf/register[2][11]} -radix unsigned} {{/system/proc1/rf/register[2][10]} -radix unsigned} {{/system/proc1/rf/register[2][9]} -radix unsigned} {{/system/proc1/rf/register[2][8]} -radix unsigned} {{/system/proc1/rf/register[2][7]} -radix unsigned} {{/system/proc1/rf/register[2][6]} -radix unsigned} {{/system/proc1/rf/register[2][5]} -radix unsigned} {{/system/proc1/rf/register[2][4]} -radix unsigned} {{/system/proc1/rf/register[2][3]} -radix unsigned} {{/system/proc1/rf/register[2][2]} -radix unsigned} {{/system/proc1/rf/register[2][1]} -radix unsigned} {{/system/proc1/rf/register[2][0]} -radix unsigned}}} {{/system/proc1/rf/register[1]} -radix unsigned} {{/system/proc1/rf/register[0]} -radix unsigned}} -expand -subitemconfig {{/system/proc1/rf/register[15]} {-height 15 -radix unsigned} {/system/proc1/rf/register[14]} {-height 15 -radix unsigned} {/system/proc1/rf/register[13]} {-height 15 -radix unsigned} {/system/proc1/rf/register[12]} {-height 15 -radix unsigned} {/system/proc1/rf/register[11]} {-height 15 -radix unsigned} {/system/proc1/rf/register[10]} {-height 15 -radix unsigned} {/system/proc1/rf/register[9]} {-height 15 -radix unsigned} {/system/proc1/rf/register[8]} {-height 15 -radix unsigned} {/system/proc1/rf/register[7]} {-height 15 -radix unsigned} {/system/proc1/rf/register[6]} {-height 15 -radix unsigned} {/system/proc1/rf/register[5]} {-height 15 -radix unsigned} {/system/proc1/rf/register[4]} {-height 15 -radix unsigned} {/system/proc1/rf/register[3]} {-height 15 -radix unsigned} {/system/proc1/rf/register[2]} {-height 15 -radix unsigned -childformat {{{/system/proc1/rf/register[2][19]} -radix unsigned} {{/system/proc1/rf/register[2][18]} -radix unsigned} {{/system/proc1/rf/register[2][17]} -radix unsigned} {{/system/proc1/rf/register[2][16]} -radix unsigned} {{/system/proc1/rf/register[2][15]} -radix unsigned} {{/system/proc1/rf/register[2][14]} -radix unsigned} {{/system/proc1/rf/register[2][13]} -radix unsigned} {{/system/proc1/rf/register[2][12]} -radix unsigned} {{/system/proc1/rf/register[2][11]} -radix unsigned} {{/system/proc1/rf/register[2][10]} -radix unsigned} {{/system/proc1/rf/register[2][9]} -radix unsigned} {{/system/proc1/rf/register[2][8]} -radix unsigned} {{/system/proc1/rf/register[2][7]} -radix unsigned} {{/system/proc1/rf/register[2][6]} -radix unsigned} {{/system/proc1/rf/register[2][5]} -radix unsigned} {{/system/proc1/rf/register[2][4]} -radix unsigned} {{/system/proc1/rf/register[2][3]} -radix unsigned} {{/system/proc1/rf/register[2][2]} -radix unsigned} {{/system/proc1/rf/register[2][1]} -radix unsigned} {{/system/proc1/rf/register[2][0]} -radix unsigned}}} {/system/proc1/rf/register[2][19]} {-height 15 -radix unsigned} {/system/proc1/rf/register[2][18]} {-height 15 -radix unsigned} {/system/proc1/rf/register[2][17]} {-height 15 -radix unsigned} {/system/proc1/rf/register[2][16]} {-height 15 -radix unsigned} {/system/proc1/rf/register[2][15]} {-height 15 -radix unsigned} {/system/proc1/rf/register[2][14]} {-height 15 -radix unsigned} {/system/proc1/rf/register[2][13]} {-height 15 -radix unsigned} {/system/proc1/rf/register[2][12]} {-height 15 -radix unsigned} {/system/proc1/rf/register[2][11]} {-height 15 -radix unsigned} {/system/proc1/rf/register[2][10]} {-height 15 -radix unsigned} {/system/proc1/rf/register[2][9]} {-height 15 -radix unsigned} {/system/proc1/rf/register[2][8]} {-height 15 -radix unsigned} {/system/proc1/rf/register[2][7]} {-height 15 -radix unsigned} {/system/proc1/rf/register[2][6]} {-height 15 -radix unsigned} {/system/proc1/rf/register[2][5]} {-height 15 -radix unsigned} {/system/proc1/rf/register[2][4]} {-height 15 -radix unsigned} {/system/proc1/rf/register[2][3]} {-height 15 -radix unsigned} {/system/proc1/rf/register[2][2]} {-height 15 -radix unsigned} {/system/proc1/rf/register[2][1]} {-height 15 -radix unsigned} {/system/proc1/rf/register[2][0]} {-height 15 -radix unsigned} {/system/proc1/rf/register[1]} {-height 15 -radix unsigned} {/system/proc1/rf/register[0]} {-height 15 -radix unsigned}} /system/proc1/rf/register
add wave -noupdate -divider {Register File}
add wave -noupdate /system/proc1/IF_ID/clock
add wave -noupdate /system/proc1/IF_ID/reset
add wave -noupdate /system/proc1/IF_ID/instruction
add wave -noupdate /system/proc1/IF_ID/instructionPropagation
add wave -noupdate -divider IF_ID
add wave -noupdate /system/proc1/ID_EX/clock
add wave -noupdate /system/proc1/ID_EX/reset
add wave -noupdate /system/proc1/ID_EX/instruction
add wave -noupdate -radix unsigned /system/proc1/ID_EX/read_data1
add wave -noupdate -radix unsigned /system/proc1/ID_EX/read_data2
add wave -noupdate -radix unsigned /system/proc1/ID_EX/dataRFOut1
add wave -noupdate -radix unsigned /system/proc1/ID_EX/dataRFOut2
add wave -noupdate /system/proc1/ID_EX/instructionPropagation
add wave -noupdate -divider ID_EX
add wave -noupdate /system/proc1/EX_MEM/clock
add wave -noupdate /system/proc1/EX_MEM/reset
add wave -noupdate /system/proc1/EX_MEM/instruction
add wave -noupdate /system/proc1/EX_MEM/aluZERO
add wave -noupdate -radix unsigned /system/proc1/EX_MEM/aluRESULT
add wave -noupdate -radix unsigned /system/proc1/EX_MEM/aluZEROout
add wave -noupdate -radix unsigned /system/proc1/EX_MEM/aluRESULTout
add wave -noupdate /system/proc1/EX_MEM/instructionPropagation
add wave -noupdate -divider EX_MEM
add wave -noupdate /system/proc1/MEM_WB/instruction
add wave -noupdate /system/proc1/MEM_WB/clock
add wave -noupdate /system/proc1/MEM_WB/reset
add wave -noupdate -radix unsigned /system/proc1/MEM_WB/aluRESULT
add wave -noupdate /system/proc1/MEM_WB/memory_read_data
add wave -noupdate -radix unsigned /system/proc1/MEM_WB/aluRESULTout
add wave -noupdate /system/proc1/MEM_WB/memory_read_data_out
add wave -noupdate /system/proc1/MEM_WB/instructionPropagation
add wave -noupdate -divider MEM_WB
add wave -noupdate /system/proc1/WB/instruction
add wave -noupdate -radix unsigned /system/proc1/WB/aluRESULTout
add wave -noupdate -radix unsigned /system/proc1/WB/memoryReadData
add wave -noupdate -radix unsigned /system/proc1/WB/address
add wave -noupdate -radix unsigned /system/proc1/WB/writeBackEnable
add wave -noupdate -radix unsigned /system/proc1/WB/writeBackAddress_Out
add wave -noupdate -radix unsigned /system/proc1/WB/writeBackData_Out
add wave -noupdate /system/proc1/WB/opcode
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1258 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 331
configure wave -valuecolwidth 152
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
WaveRestoreZoom {1165 ps} {1623 ps}
view wave 
wave clipboard store
wave create -driver freeze -pattern clock -initialvalue HiZ -period 100ps -dutycycle 50 -starttime 0ps -endtime 2000ps sim:/system/Clock 
wave create -driver freeze -pattern constant -value 0 -starttime 0ps -endtime 2000ps sim:/system/Reset 
wave modify -driver freeze -pattern constant -value 1 -starttime 60ps -endtime 110ps Edit:/system/Reset 
WaveCollapseAll -1
wave clipboard restore
