#!/bin/bash
cat user.txt |awk -F: '{ print $1}' | xargs -n 1 useradd -m
for i in `cat user.txt |awk '{print$1}'`
do
	touch /home/$i/work && echo -e "создан" > /home/work/result
done
chpasswd < pass.txt
# выводим список репозитариев
apt-cache policy | grep http | awk '{print $2 $3}' | sort -u 

#Проверка на наличие репозитория Backports в списке репозиториев.
if ! grep -q "^deb .*backports" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
# если нет добавить
    echo "deb http://deb.debian.org/debian buster-backports main" | sudo tee -a /etc/apt/sources.list.d/backports.list
fi

# Update apt
sudo apt update

# Install Apache2
sudo apt install -y apache2

# Install Python
sudo apt install -y python3 python3-pip

# Install SSH server
sudo apt install -y openssh-server

# Start Apache2 and SSH server
sudo systemctl start apache2
sudo systemctl start ssh
