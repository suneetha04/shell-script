#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"]

LOGS_FOLDER="/var/log/shell-script-logs"
LOG_FILE=$(echo $0 | cut -d "." -f1 )
TIMESTAMP=$(date +%y-%m-%d-%H-%M-%S)
LOG_FILE_NAME="$LOGS_FOLDER/$LOGS_FILE-$$TIMESTAMP.log"

VALIDATE(){
    if [ $1 -ne 0 ]
    then
       echo -e "$2... $R FAILURE $N"
       exit1
    else
       echo -e "$2... $G SUCCESS $N"
    fi
}

echo "script started executing at :$TIMESTAMP" &>>$LOG_FILE_NAME

if [ $USERID -ne 0 ]
then
   echo "ERROR: you must have sudo access for this execution"
   exit1 #other than 0
fi

dnf list installed mysql  &>>$LOG_FILE_NAME

if [ $? -ne 0 ]
then # not installed
   dnf install mysql -y  &>>$LOG_FILE_NAME
   VALIDATE $? "Installing MySQL"
else
   echo -e "MySQL is already ....$Y installed $N"
fi

dnf list installed git  &>>$LOG_FILE_NAME

if [ $? -ne 0 ]
then
   dnf install git -y &>>$LOG_FILE_NAME
   VALIDATE $? "Installing GIT"
else
   echo  -e "GIT is already....$Y installed $N"
fi
