!#/bin/bash

#Instalación del Setup

function installing_setup {
	#Desactivar SElinux
	sudo setenforce 0;
	
	#Descargar Repo EPEL
	sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm;
	
	#Desactivar postgres/nginx
	sudo dnf module disable postgresql -y; 
	sudo dnf module disable nginx –y;
	
	#Donwload Python
	sudo dnf install -y python2;
	sudo ln -s /usr/bin/python2 /usr/bin/python;
	
	#Donwload utils
	sudo yum install yum-utils -y;
	
	#Donwload Booststrap/Install
	curl https://software.apigee.com/bootstrap_4.51.00.sh -o /tmp/bootstrap_4.51.00.sh;
	sudo bash /tmp/bootstrap_4.51.00.sh apigeeuser=amermovil1 apigeepassword=9K4-E-6--1G_---;
	
	/opt/apigee/apigee-service/bin/apigee-service apigee-setup install 
	

installing_components
}


function installing_components {

#topologia x5
IP=$(hostname -i);

case $IP in
  10.25.114.141)
    /opt/apigee/apigee-setup/bin/setup.sh -p ds -f /tmp/configFile;
	validate_installation
  ;;
  10.25.114.142)
     /opt/apigee/apigee-setup/bin/setup.sh -p ds -f /tmp/configFile;
	 validate_installation
  ;;
  10.25.114.143)
    /opt/apigee/apigee-setup/bin/setup.sh -p ds -f /tmp/configFile;
	validate_installation
  ;;
  10.25.114.141)
    /opt/apigee/apigee-setup/bin/setup.sh -p ms -f /tmp/configFile;
	validate_installation
  ;;
  10.25.114.142)
   /opt/apigee/apigee-setup/bin/setup.sh -p rmp -f /tmp/configFile;
   validate_installation
  ;;
  10.25.114.143)
   /opt/apigee/apigee-setup/bin/setup.sh -p rmp -f /tmp/configFile;
   validate_installation
  ;;
  10.25.114.144)
  /opt/apigee/apigee-setup/bin/setup.sh -p sax -f /tmp/configFile;
  validate_installation
  ;;
  10.25.114.145)
  /opt/apigee/apigee-setup/bin/setup.sh -p sax -f /tmp/configFile;
  validate_installation
  ;;
  10.25.114.141)
  /opt/apigee/apigee-service/bin/apigee-service edge-ui restart;
  validate_installation
  ;; 
esac
}

function validate_installation {

#validar estados de los components
/opt/apigee/apigee-service/apigee-edge/apigee-all status;
}


function create_org {
/opt/apigee/apigee-service/bin/apigee-service apigee-provision install;

validate_org
}

#function validate_org {
#<commands>
#}