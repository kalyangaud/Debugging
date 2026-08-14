## Finding possibilites of server crashing

check_process(){
	SERVICE=apache2

	echo
	echo"Checking running processes...."

	if ps aux | grep "[a]pache2" >/dev/null;
	then
		echo "Apache process found"
	else
		echo"Apache process not found"
		echo"DEBUG: The service may have crashed"
	fi
}
