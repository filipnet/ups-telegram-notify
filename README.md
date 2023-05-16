# ups-telegram-notify
Notification of the status of an Uninterruptible Power Supply by Telegram
In the event of a power failure, you may want to be notified in order to check systems that are not protected. It is also interesting to know whether there has been a prolonged power failure and whether measures have been initiated in the form of shutdowns. To realise this via the messanger Telegram, this Linux script solution can be used.

## DOWNLOAD AND INSTALLATION 

Download von Notification Script von Github-Repository
```
cd  /etc/nut
wget https://raw.githubusercontent.com/filipnet/ups-telegram-notify/main/notifycmd.sh
```

## CONFIGURATION 

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
## LICENSE 

ups-telegram-notify and all individual scripts are under the BSD 3-Clause license unless explicitly noted otherwise. Please refer to the LICENSE
