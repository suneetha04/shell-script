#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
LOGS_FOLDER="/var/log/shell-script-logs"
LOG_FILE=$(echo $0 | cut -d "." -f1 )
TIMESTAMP=$(date +%y-%m-%d-%H-%M-%S)
LOG_FILE_NAME="$LOGS_FOLDER/$LOGS_FILE-$$TIMESTAMP.log"

VALIDATE(){
    if [ $1 -ne 0 ]
    then
       echo -e "$2... $R FAILURE"
       exit1
    else
       echo -e "$2... $G SUCCESS"
    fi
}

echo "script started executing at :$TIMESTAMP" &>>$LOG_FILE

if [ $USERID -ne 0 ]
then
   echo "ERROR: you must have sudo access for this execution"
   exit1 #other than 0
fi

dnf list installed mysql  &>>$LOG_FILE

if [ $? -ne 0 ]
then # not installed
   dnf install mysql -y  &>>$LOG_FILE
   VALIDATE $? "Installing MySQL"
else
   echo -e "MySQL is already ....$Y installed"
fi

dnf list installed git  &>>$LOG_FILE

if [ $? -ne 0 ]
then
   dnf install git -y &>>$LOG_FILE
   VALIDATE $? "Installing GIT"
else
   echo  -e "GIT is already....$Y installed"
fi
