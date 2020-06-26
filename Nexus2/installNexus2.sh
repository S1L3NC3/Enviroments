#!/bin/bash
eth1ip=$(ifconfig |grep -A 1 eth1 | grep inet |awk '{print $2}')
echo "========================= Ajustes del sistema ==================================="
echo "******** Esto puede llevar unos minutos, por favor, mantente a la espera ********"
echo "******** No intentes cerrar el proceso.                                  ********"
echo "******** Este entorno está preparado para poder trabajar inmediatamente  ********"
echo "******** sobre la interfaz de red Bridge virtual                         ********"
echo "================================================================================="
sudo hostnamectl set-hostname nexus2.jddr.lan
sudo sed -i 's/SELINUX=permissive/SELINUX=disabled/g' /etc/selinux/config
sudo yum upgrade -y &> /home/vagrant/upgrade.txt
sudo yum install epel-release -y &> /home/vagrant/epel.txt
sudo yum install wget net-tools java-1.8.0-openjdk.x86_64 -y
sudo mkdir /home/vagrant/installer
cd /home/vagrant/installer
sudo wget https://download.sonatype.com/nexus/professional-bundle/nexus-professional-2.14.8-01-bundle.tar.gz --no-check-certificate
sudo group add nexus
sudo groupadd nexus
sudo useradd nexus -d /home/nexus -g nexus
sudo tar -zxvf nexus-professional-2.14.8-01-bundle.tar.gz