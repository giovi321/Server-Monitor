# Server-Monitor
Bash script that pings a server to check when it goes offline and when it comes back online. Sends email notifications.

## Brief explanation of the script
This bash script pings a server (in  my case through a vpn). If it receives an answer, it writes down in a file the date and time. If before that the server was down, the script sends an email to notify that the server is up again (checking is the file seenboolean.txt exists). If it doesn't receive an aswer to the ping, the scripts checks if at the previous cycle of the script the server was down. If it was already down, the script doesn't send an email, but if it wasn't down, it sends an email telling when the server was last seen.

## Create crontab job
* crontab -e
* Paste at the end the following line if you want to execute it every 5 minutes

*/5 * * * * /path/to/the/script/servermonitor.sh

* Paste at the end the following line if you want to execute it every 30 minutes

*/30 * * * * /path/to/the/script/servermonitor.sh

* Paste at the end the following line if you want to execute it every hour

@hourly /path/to/the/script/servermonitor.sh

## Requirements
* sendemail (see my other repository "sendemail-fix" to be able to use it with gmail)
* fping
* crontab

Tested under Debian 7 and Debian 8.
