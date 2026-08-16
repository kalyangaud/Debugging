##SERVER RUNNING SLOW :CPU CHECK

echo "Checking server status..."

CPU=$(top -bn1 | grep Cpu | awk '{print $2}')
 
echo "CPU usage: $CPU%"

if awk "BEGIN {exit !($CPU >80)};
then
	echo "Warning:CPU usage is too high."
fi

TOP_PROCESS=$(ps -eo pid,comm,%cpu --sort=-%cpu | head -n 2 | tail -n 1)
echo "Top CPU consuming process:"
echo "$TOP_PROCESS"

 echo "Done"
