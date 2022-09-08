# About
When running Ubiquiti Networks mPower devices without the "mFi Controller" software the local log file of the device gets spammed with error messages. Additionally, for WiFi devices, it may happen that the WiFi connection drops for a few seconds.

This tool stops those controller connections.

# Warning
Use at your own risk!
Use only with Firmware `MF.v2.1.11`.

# Installation
Download both install-nocontroller.sh and start.sh to your local device, and then copy them via
SSH to your plug. An example for Linux or macOS would look like this:
```
cd /tmp
wget https://raw.githubusercontent.com/magcode/mpower-tools/master/nocontroller/install-nocontroller.sh
wget https://raw.githubusercontent.com/magcode/mpower-tools/master/nocontroller/start.sh
scp -oKexAlgorithms=+diffie-hellman-group1-sha1 start.sh install-nocontroller.sh ubnt@MFI-IP:
```
Now we SSH into the plug and execute the install.
Enter the following commands

```
sh ./install-nocontroller.sh
save
reboot
```

Now the device will reboot.

You can check if the installation was successful:

Directly after the device is online again, connect with SSH and call

```
tail -f /var/log/messages
```

You will see some log messages like this

```
Sep  8 18:17:34 mpower-beamer user.err syslog: ace_reporter.reporter_fail(): server unreachable
Sep  8 18:17:34 mpower-beamer user.err syslog: ace_reporter.reporter_fail(): initial contact failed #4, url=http://mfi:6080/inform, rc=1
```

Approx. 3 minutes after booting you will see something like this:

```
Sep  9 09:00:28 mpower-sz daemon.info init: starting pid 4747, tty '/dev/null': '/bin/mcad -d'
Sep  9 09:00:29 mpower-sz daemon.info init: process '/bin/mcad' (pid 995) exited. Scheduling for restart.
Sep  9 09:00:30 mpower-sz daemon.info init: process '/bin/mcad -d' (pid 4747) exited. Scheduling for restart.
Sep  9 09:00:30 mpower-sz daemon.info init: starting pid 4904, tty '/dev/null': '/bin/mcad -d'
```

Now, the "server unreachable" messages should not appear anymore.
Credits to [jko74](https://community.ubnt.com/t5/mFi/Disable-controller-on-2-1-1/m-p/1121528#M10171) who was giving the right hints how to solve the issue.