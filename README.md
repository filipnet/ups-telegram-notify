# ups-telegram-notify
Notification of the status of an Uninterruptible Power Supply by Telegram

Download von Notification Script von Github-Repository
```
cd  /etc/nut
wget https://raw.githubusercontent.com/filipnet/ups-telegram-notify/main/notifycmd.sh
```
Don´t forget to change the first lines ```GROUP_ID```and ```BOT_TOKEN``` Parameters inside the script.

Open file ```/etc/nut/upsmon.conf```with your favorite editor (vim/nano) and add the following lines to the end of the config file.

```
# Email script for NOTIFYCMD
NOTIFYCMD "/etc/nut/notifycmd.sh"

# Notification events
NOTIFYFLAG ONLINE     SYSLOG+WALL+EXEC
NOTIFYFLAG ONBATT     SYSLOG+WALL+EXEC
NOTIFYFLAG LOWBATT    SYSLOG+WALL+EXEC
NOTIFYFLAG FSD        SYSLOG+WALL+EXEC
NOTIFYFLAG COMMOK     SYSLOG+WALL+EXEC
NOTIFYFLAG COMMBAD    SYSLOG+WALL+EXEC
NOTIFYFLAG SHUTDOWN   SYSLOG+WALL+EXEC
NOTIFYFLAG REPLBATT   SYSLOG+WALL+EXEC
NOTIFYFLAG NOCOMM     SYSLOG+WALL+EXEC
NOTIFYFLAG NOPARENT   SYSLOG+WALL+EXEC
```

Restart nut services to take affect
```
sudo systemctl restart nut-server.service
sudo systemctl restart nut-driver.service
sudo systemctl restart nut-monitor.service
```
