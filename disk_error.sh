## Debuggging if disk problem in server

check_disk(){
	echo
	echo "Checking disk usage..."
	
	df -h /
	if dfn -h / | awk 'NR==2 {gsub("%","",$5);
		if ($5>90) exit 1;
		else
			exit 0}'; then
			echo "Disk usage is normal"
		else
			echo "Disk usage is too high"
			echo "DEBUG: The disk may be full"
			echo "________________________"
			echo "Please free some disk memory "
			free -h
	fi
}

