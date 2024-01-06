#!/bin/bash

# Делаем пользователя судоером
echo "vagrant ALL=(ALL) NOPASSWD:ALL">/etc/sudoers.d

# Устаанавливаем необходимо ПО
sudo yum update -y
sudo yum groupinstall "Development Tools" -y
sudo yum install ncurses-devel bison flex elfutils-libelf-devel openssl-devel -y

# Получаем и распаковываем исходики ядра
wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.x.y.tar.xz
tar -xf linux-5.x.y.tar.xz
cd linux-5.x.y/

# Включаем CONFIG_SYNPROXY
make menuconfig

# Собираем и устанавливаем ядро
make -j$(nproc)
sudo make modules_install
sudo make install

# Обновление параметров GRUB
grub2-mkconfig -o /boot/grub2/grub.cfg
grub2-set-default 0
echo "Grub update done."
# Перезагрузка ВМ
shutdown -r now