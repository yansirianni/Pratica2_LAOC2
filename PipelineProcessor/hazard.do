view wave 
wave clipboard store
wave create -driver freeze -pattern clock -initialvalue HiZ -period 100ps -dutycycle 50 -starttime 0ps -endtime 2000ps sim:/system/Clock 
wave create -driver freeze -pattern constant -value 0 -starttime 0ps -endtime 2000ps sim:/system/Reset 
wave modify -driver freeze -pattern clock -initialvalue HiZ -period 100ps -dutycycle 50 -starttime 2000ps -endtime 4000ps Edit:/system/Clock 
WaveCollapseAll -1
wave clipboard restore
