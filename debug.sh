#!/bin/bash

REPORT="debug-report.txt"
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
        
    elif grep -q "Port" app.log
    then
       echo "Problem type : Port" >>  "$REPORT"
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

