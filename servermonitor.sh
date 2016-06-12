#!/bin/sh
# Server monitor
#

##### PARAMETERS START #####
servername="Name of your server" # Name of the server to be checked
ip="10.10.10.10" # IP of the server to be checked
logdate=$(date +"%m-%Y")
scriptlog="/var/log/servermonitor/script_$logdate.log"
seendate=$(date +"%d-%m-%Y %H:%M:%S")
seenlog="/var/log/servermonitor/seenlog.txt"
seenlogdir="/var/log/servermonitor/"
seenboolean="/var/log/servermonitor/seenboolean.txt"
seen=$(head -1 /var/log/servermonitor/seenlog.txt)
mittente="servername@gmail.com" # Sender of the email
dest="someone@somewhere.com" # Recipient of the email
smtp="smtp.gmail.com:587" # Default gmail settings
username="servername@gmail.com"
pass="VerySecurePassword"
messaggio="$servername does not respond to ping since $seen." # Message in case the server is down
oggetto="servername: $servername down." # Subject in case the server is down
messaggio2="$servername now responds to ping. Was not responding since $seen." # Message in case the server is up
oggetto2="servername: $servername up." # Subject in case the server is up
inviamail="sendemail -f $mittente -t $dest -u $oggetto -s $smtp -o tls=yes -xu $username -xp $pass -m $messaggio"
inviamail2="sendemail -f $mittente -t $dest -u $oggetto2 -s $smtp -o tls=yes -xu $username -xp $pass -m $messaggio2"
###### PARAMETERS END ######

mkdir $seenlogdir >/dev/null

echo "$(date +"%D %T") : server monitor." >>$scriptlog
echo "Pinging $ip." >>$scriptlog
if fping -c 1 -t 500 $ip >/dev/null
then
  echo "Answer to the ping received from $ip." >>$scriptlog
  if [ ! -f $seenboolean ]
  then
        echo "server was down but now is up. Sending email." >>$scriptlog
    $inviamail2  >>$scriptlog
  else
        :
  fi
  touch $seenboolean
  echo $seendate >$seenlog
else
  echo "No answer received to the ping." >>$scriptlog
  if [ -f $seenboolean ]
  then
    echo "Sending email." >>$scriptlog
    $inviamail  >>$scriptlog
  else
    :
  fi
  rm $seenboolean
fi
