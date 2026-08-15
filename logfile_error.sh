##Servivce problem debug

SERVICE=nginx
PORT=8080
LOG_FILE="/var/log/nginx/error/.log"

echo "--------WEB APPLICATION DEBUG---------"

check_logs(){
	echo 
	echo "Checking logs...."

	if [ -f "$LOG_FILE"];then
		echo "Last 10 log entries:"
		tail -10 "$LOG_FILE"
	else
		echo "LOG file not found"
	fi
}
check_memory(){
	echo 
	echo "Checking memories usage......."

	free -h
}

check_logs
check_memory
