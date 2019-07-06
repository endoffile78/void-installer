#!/bin/bash

RDISK=$1
USR=$1

source config.sh

chown root:root /
chmod 755 /

echo "Setting timezone to ${TIMEZONE}"
ln -s /usr/share/zoneinfo/$TIMEZONE /etc/localtime

echo "Setting hostname to ${HOSTNAME}"
echo "${HOSTNAME}" > /etc/hostname

echo "Creating user: ${USR}"
useradd -m -G wheel,floppy,audio,video,optical,cdrom -s /bin/bash $USR
passwd $USR

echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "en_US.UTF-8 UTF-8" >> /etc/default/libc-locales
xbps-reconfigure -f glibc-locales

# setup fstab
echo "Setting up /etc/fstab"
vim /etc/fstab

echo "Setting up /et/rc.conf"
echo "TIMEZONE=${TIMEZONE}" > /etc/rc.conf
echo "KEYMAP=${KEYMAP}" >> /etc/rc.conf

uuid=`ls -l /dev/disk/by-uuid/ | grep $(basename $RDISK) | awk '{print $9}'`

# install and configure refind
refind-install
echo "\"Boot with standard options\" cryptdevice=$uuid:$VOLUME root=$ROOT rw quiet initrd=/initramfs-%v.img rd.auto init=/sbin/init vconsole.unicode=1 vconsole.keymap=${KEYMAP}" >> /boot/refind_linux.conf

# setup mulilib and nonfree repos
xbps-install -Sy $REPOS

# change mirror to one in the united states
mkdir -p /etc/xbps.d/
cp /usr/share/xbps.d/*-repository-*.conf /etc/xbps.d/
sed -i 's|https://alpha.de.repo.voidlinux.org|${REPO}|g' /etc/xbps.d/*-repository-*.conf

# update
xbps-install -Syu

xbps-install -Sy $PACKAGES
