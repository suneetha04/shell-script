#!/bin/bash

#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"

]]
VALIDATE(){
    if [ $1 -ne 0 ]
    then
       echo -e "$2... $R FAILURE"
       exit1
    else
       echo -e "$2... $G SUCCESS"
    fi
}

if [ $USERID -ne 0 ]
then
   echo "ERROR: you must have sudo access for this execution"
   exit1 #other than 0
fi

dnf list installed mysql

if [ $? -ne 0 ]
then # not installed
   dnf install mysql -y
   VALIDATE $? "Installing MySQL"
else
   echo -e "MySQL is already ....$Y installed"
fi

dnf list installed git

if [ $? -ne 0 ]
then
   dnf install git -y
   VALIDATE $? "Installing GIT"
else
   echo  -e "GIT is already....$Y installed"
fi