# ups-telegram-notify
Notification of the status of an Uninterruptible Power Supply by Telegram

<img src="images\telegram-notification-example.png" alt="Telegram notification example" width="400" align="right"/>
In the event of a power failure, you may want to be notified in order to check systems that are not protected. It is also interesting to know whether there has been a prolonged power failure and whether measures have been initiated in the form of shutdowns. To realise this via the messanger Telegram, this Linux script solution can be used.

## REQUIREMENT DEPENDENCIES

Debian: ```apt-get install nut```

Redhat: ```dnf install nut -y```

## NUT CONFIGURATION EXAMPLE

### /etc/nut/ups.conf
```
[eaton]
   driver = usbhid-ups
   port = auto
   vendorid = 0463
   pollfreq = 30
```
### /etc/nut/nut.conf
```
MODE=netserver
LISTEN 0.0.0.0 3493
LISTEN ::1 3493
```
### /etc/nut/upsd.user
```
[upsmon]
      password = supersecretpassword
      upsmon master
      actions = SET
      instcmds = ALL
```
### /etc/nut/upsmon.conf
```
MONITOR eaton@127.0.0.1 1 upsmon supersecretpassword master
POWERDOWNFLAG /etc/killpower
SHUTDOWNCMD "/sbin/shutdown -h now"
```
### Enable and starting service
```
sudo systemctl enable nut-server.service && sudo systemctl start nut-server.service
sudo systemctl enable nut-monitor.service && sudo systemctl start nut-monitor.service
sudo systemctl status nut-server.service
sudo systemctl status nut-monitor.service
netstat -tulpen |grep 3493
```

## DOWNLOAD AND INSTALLATION 

Download von Notification Script von Github-Repository
```
cd  /etc/nut
wget https://raw.githubusercontent.com/filipnet/ups-telegram-notify/main/notifycmd.sh
chmod +x notifycmd.sh
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
## TEST / DRY-RUN

Execute the script: 
```
cd /etc/nut/
./notifycmd.sh
```
## LICENSE 

ups-telegram-notify and all individual scripts are under the BSD 3-Clause license unless explicitly noted otherwise. Please refer to the LICENSE
