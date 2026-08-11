#!/bin/bash

REPORT="debug-report.txt"
PORT=8080
Expected_process= " python"
echo "Checking software..."
echo "-------------------------------------" > "$REPORT"
echo "APPLICATION DEBUGGING REPORT" >>  "$REPORT"
echo "-------------------------------------" >>  "$REPORT"
echo "Time : $(date)" >>  "$REPORT"
echo "" >>  "$REPORT"

errors=$(grep -c "ERROR" app.log)
echo "Checking application...... "
echo "Errors found : $errors "

if [ "$errors" -gt 0 ]
then
    echo "Status : Problem detected" >>  "$REPORT"

    if grep -q "Database" app.log
    then
       echo "Problem type : Database" 
       echo "Problem type : Database" >>  "$REPORT"
       echo "Attempting recovery....." >>  "$REPORT"
       echo "UP" > app.status
       if [ "$(cat app.status)" = "UP" ]
       then
            echo "Recovery : Success"
           echo "Recovery : Success" >>  "$REPORT"
           echo " Application : UP" >>  "$REPORT"
       else
           echo "Recovery : Failed"  >>  "$REPORT"
           echo " Application : Still Down" >>  "$REPORT"
    fi
        
    elif echo "Checking port $PORT..."

    if ss -lnt| grep -q ":$PORT"
    then

	    echo "Port $PORT is listening" >> 
	    PID=$(sudo ss -lntp | grep ":$PORT" | grep -o 'pid=[0-9]*' | cut -d= -f2)
	    PROCESS=$(ps -p "$PID" -o comm= )
	    echo "Port $PORT is being used by another PID : $PID" 
	    echo "Process using port $PORT : $PROCESS" 
	    if ["$PROCESS" = "$Expected_process" ]; then
		    echo " Correct Application is using port $PORT" 
	 

            else
	            echo "Problem type : Port"
                    echo "Problem type : Port" >>  
	            echo " Port $PORT is not listening" >> 
	            echo "DEBUG : Nothing is listening on port $PORT" 
		    echo " Port $PORT is occupied by unexpected process : $PROCESS" 
		    echo " DEBUG: Possible port conflict detected" 
    fi

    elif grep -q "Permission" app.log
    then
       echo "Problem type : Permission" >>  "$REPORT"
    else
       echo "Problem type : Unknown" >>  "$REPORT"
    fi 

    echo ""  >>  "$REPORT"   
    echo "Error details:" >>  "$REPORT"
    grep "ERROR" app.log >>  "$REPORT"
else
    echo "Status : Application healthy" >>  "$REPORT"
fi
echo "" >>  "$REPORT"
echo " Debugging Completed." >>  "$REPORT"

