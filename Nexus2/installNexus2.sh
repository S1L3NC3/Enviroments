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
echo "******** Comienza el proceso de instalación de Nexus 2 **************"
echo "STEP 1: Descarga de Nexus 2.14.08-01"
sudo wget -q https://download.sonatype.com/nexus/oss/nexus-2.14.8-01-bundle.tar.gz --no-check-certificate
echo "STEP 2: Descompresión en /opt"
sudo tar -xf * -C /opt
echo "STEP 3: Adición usuario nexus y filesystem propietario"
sudo useradd nexus
sudo chown -R nexus:nexus /opt/nexus-2.14.8-01/
echo "STEP 4: Modificación de fichero de configuración y enlance simbólico a init.d"
sudo sed -i 's/#RUN_AS_USER=/RUN_AS_USER=nexus/g' /opt/nexus-2.14.8-01/bin/nexus
sudo ln -s /opt/nexus-2.14.8-01/bin/nexus /etc/init.d/nexus
echo "STEP 5: Habilitar Nexus para inicio e iniciar."
sudo systemctl enable nexus
sudo systemctl start nexus
echo "FIN ===================================================================================="
echo "Puedes acceder a http://$eth1ip:8081/nexus"
echo "User: admin / Password: admin123"