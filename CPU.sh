##SERVER RUNNING SLOW :CPU CHECK

echo "Checking server status..."

CPU=$(top -bn1 | grep Cpu | awk '{print $2}')
 if
	 ["$CPU" -gt 80 ];then
	 echo "Warning :CPU uasge is too high"
 fi
 echo "Done"
