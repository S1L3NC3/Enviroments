#!/bin/bash
eth1ip=$(ifconfig |grep -A 1 eth1 | grep inet |awk '{print $2}')
echo "========================= Ajustes del sistema ==================================="
echo "******** Esto puede llevar unos minutos, por favor, mantente a la espera ********"
sudo hostnamectl set-hostname checkmk.jddr.lan
sudo sed -i 's/SELINUX=permissive/SELINUX=disabled/g' /etc/selinux/config
sudo yum upgrade -y &> /home/vagrant/upgrade.txt
sudo yum install epel-release -y &> /home/vagrant/epel.txt
echo "======= Instalación de paquetes ========="
sudo yum install nmap net-tools wget time traceroute dialog php libcap libgsf rpm-build postgresql-libs graphviz libdbi xinetd libcap poppler-utils graphviz-gd perl-Locale-Maketext-Simple perl-IO-Zlib php-xml php-xml php-pdo php-gd uuid freeradius-utils libpcap bind-utils php-mbstring -y
echo "========= Descarga de CheckMK =========="
cd /home/vagrant
sudo wget https://checkmk.com/support/1.6.0p10/check-mk-raw-1.6.0p10-el7-38.x86_64.rpm --no-check-certificate
echo "======== INSTALACION DE CHECKMK ========"
sudo rpm -i check-mk-raw-1.6.0p10-el7-38.x86_64.rpm &> /home/vagrant/proceso.txt
echo "======== CREANDO 4 SITES ==============="
sudo omd create PRE  
sudo omd create PRO
sudo omd create DES
sudo omd create TST
echo "========= CONFIGURANDO SITES ============="
htpasswd -mb /omd/sites/PRO/etc/htpasswd cmkadmin PRO
htpasswd -mb /omd/sites/PRE/etc/htpasswd cmkadmin PRE
htpasswd -mb /omd/sites/DES/etc/htpasswd cmkadmin DES
htpasswd -mb /omd/sites/TST/etc/htpasswd cmkadmin TST
omd restart
echo "========== Limpieza ficheros ============"
sudo yum clean all
cd /home/vagrant
sudo rm /home/vagrant/proceso.txt
yum clean all
echo "============================================================="
echo "========================= INFORMACION ======================="
echo "============================================================="
echo "Versión CheckMK:                                    1.6.0.p10"
echo "Usuario de acceso web:                               cmkadmin"
echo "Para acceder a PRO: http://$eth1ip/PRO . Contraseña: PRO"
echo "Para acceder a PRE: http://$eth1ip/PRE . Contraseña: PRE"
echo "Para acceder a DES: http://$eth1ip/DES . Contraseña: DES"
echo "Para acceder a TST: http://$eth1ip/TST . Contraseña: TST"
echo "Más información de la instalación en:          /home/vagrant/"
echo "============================================================="
