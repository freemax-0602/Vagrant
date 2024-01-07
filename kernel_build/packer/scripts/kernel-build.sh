#!/bin/bash

# Добавление ssh-ключа для пользователя vagrant
mkdir -pm 700 /home/vagrant/.ssh
curl -sL https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub -o /home/vagrant/.ssh/authorized_keys
chmod 0600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh

# Устаанавливаем необходимо ПО
sudo yum update -y
sudo yum groupinstall "Development Tools" -y
sudo yum install ncurses-devel bison flex elfutils-libelf-devel openssl-devel -y

# Получаем и распаковываем исходики ядра
wget https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.6.9.tar.xz
tar -xf linux-6.6.9.tar.xz
cd linux-6.6.9/

# Включаем CONFIG_SYNPROXY
make defconfig

# Собираем и устанавливаем ядро
make -j$(nproc)
sudo make modules_install
sudo make install

# Обновление параметров GRUB
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
sudo grub2-set-default 0
echo "Grub update done."
# Перезагрузка ВМ
shutdown -r now