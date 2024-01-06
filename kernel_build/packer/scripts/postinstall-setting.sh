#!/bin/bash

# Устанавливаются необходимые компоненты
sudo yum install -y kernel-devel kernel-headers dkms make bzip2 perl

# Устанавливаем дополнения VBox
sudo mount /dev/cdrom /mnt
sudo /mnt/VBoxLinuxAdditions.run
sudo umount /mnt
sudo systemctl enable vboxservice

# Конфигурирем SYN-Proxy
sudo echo 1 > /proc/sys/net/ipv4/ip_forward
sudo iptables -t raw -I PREROUTING -p tcp -m tcp --syn -j CT --notrack
sudo iptables -A INPUT -p tcp -m tcp --syn -j ACCEPT

sudo iptables -A INPUT -p tcp -m state --state INVALID -j DROP
sudo iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT

sudo iptables-save
