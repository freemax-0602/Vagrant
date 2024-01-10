**Домашнее задания №1**

**Тема** ***"С чего начинается Linux"***

**Задачи**
1. Обновить ядро ОС из репозитория ELRepo
2. Загрузить Vagrant box с помощью Packer
3. Загрузить Vagrant box в Vagrant Cloud

**Дополнительные задания**
- ядро собранно из исходников
- в образе нормально работают VirtualBox Shared Folders

**Дополнительное задания от преподователя** 
- собрать ядро с поддеркой SYN-Proxy 
--- 
**Результат выполнения задания** 

***Основное задание***
 Каталог `kernel_update/packer`

1. Создан файл `packer/centos.json` с учетом следующего: 
- образ получен с актуального зеркала и проверена контрольная сумма 
- в разделе `boot_command` добавлено указание на файл ks.cfg
- в разделе `provisioners` добавлено указание на файлы со скриптами
     
2. Создан файл автоматической конфигурации ОС - `http/ks.cfg`

3. Создан файл `scripts/kernel-update.sh` описывающий команды по обновлению ядра

4. Создан файл `scripts/clean.sh` содержащий команды очистки и добавления ssh-ключа пользователя vagrant

5. Запущена сборка образа командой
```
packer build centos.json
```
6. После выполнения данной команды собран образ ОС, в котором применены вышеописанные скрипты. Результатом сборки является файл `*.box`
```
.rw-rw-r-- 4,8G freemax freemax 10 янв 00:42 centos-8-kernel-6-x86_64-Minimal.box
```
7.  На основе образа создан VagrantFile и проверено обновления ядра
```
vagrant box add --name centos-kernel6/ centos-8-kernel-6-x86_64-Minimal.box

vagrant box list                                                     
centos-kernel6 (virtualbox, 0)

vagrant init centos-kernel6

vagrant up

vagrant ssh

vagrant ssh
Activate the web console with: systemctl enable --now cockpit.socket

Last login: Tue Jan  9 16:37:53 2024 from 10.0.2.2
[vagrant@otus-c8 ~]$ uname -r
6.6.10-1.el8.elrepo.x86_64
[vagrant@otus-c8 ~]$ exit
выход

```
