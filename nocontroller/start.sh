#!/bin/sh

echo "nocontroller starts"
mount --bind /var/etc/persistent/nocontroller/syswrapper.sh /usr/etc/syswrapper.sh
sed -e 's/mcad/mcad -d/' /etc/inittab > /tmp/inittab && mv /tmp/inittab /etc/inittab
kill -HUP 1
pkill -9 mcad
