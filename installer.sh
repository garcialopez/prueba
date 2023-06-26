#!/bin/bash

# Colores
verde="\e[32m"
rojo="\e[31m"
fucsia="\e[35m"
amarillo="\e[33m"
blanco="\e[37m"
azul="\e[34m"
reset="\e[0m"

repositorio="https://github.com/adriantecnm/ServerPHP.git"
carpeta="ServerPHP"

# Le damos permiso de ejecución al logo
sudo chmod +x logo.sh

# Ejecutamos nuestro logo
bash logo.sh

instalar() {
  local paquete="$1"

  if dpkg -s "$paquete" >/dev/null 2>&1; then
    echo -e "${verde}El paquete $paquete está instalado.${reset}"
  else
    echo "El paquete $paquete no está instalado."
    echo -e "${fucsia}Lo estamos instalando...${reset}\n"
    sleep 3
    sudo rm /var/lib/dpkg/lock
    sudo rm /var/lib/apt/lists/lock
    sudo rm -f /var/cache/apt/archives/lock /var/lib/dpkg/lock-frontend
    sleep 2
    sudo apt install "$paquete" -y
    echo -e "${verde}Terminó la instalación.${reset}"
  fi
}

echo "-----------------------------------------------"
echo -e "${verde}Iniciando configuración del servidor web.${reset}"
echo "-----------------------------------------------"

echo -e "\n${fucsia}Estamos actualizando todos los paquetes...${reset}"
sudo apt update
echo -e "\n${verde}Actualización terminada.${reset}"

echo -e "\n${azul}Instalando apache2...${reset}"
instalar "apache2"

echo -e "\n${azul}Instalando mysql-server...${reset}"
instalar "mysql-server"

echo -e "\n${rojo}Configurando seguridad MySQL${reset}"
# Ejecutar mysql_secure_installation y proporcionar respuestas directamente
echo -e "N\nadrian\nadrian\ny\ny\ny\ny" | sudo mysql_secure_installation
echo -e "\n${verde}Configuración terminada.${reset}"

echo -e "\n${azul}Instalando PHP y sus librerías básicas${reset}"
instalar "php"
instalar "libapache2-mod-php"
instalar "php-mysql"


echo -e "\n${rojo}Reiniciando el servidor${reset}"
sudo systemctl restart apache2
echo -e "${verde}Servidor reiniciado.${reset}"

echo -e "\n${rojo}Configuración de contraseña para usuario root en MySQL${reset}"
# Ejecutar el cliente de MySQL como superusuario
sudo mysql <<EOF

ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'adrian';

FLUSH PRIVILEGES;

exit;

EOF

echo -e "\n${azul}Instalando utilidades de PHP.${reset}"
instalar "php-mbstring"
instalar "php-gettext"

echo -e "\n${azul}Instalando phpmyadmin.${reset}"
instalar "phpmyadmin"

echo -e "\n${rojo}Realizando las ultimas configuraciones.${reset}"
sudo phpenmod mbstring

echo -e "\n${rojo}Reiniciando el servidor${reset}"
sudo systemctl restart apache2
echo -e "${verde}Servidor reiniciado.${reset}"

echo -e "\n${azul}Instalando git.${reset}"
instalar "git"

echo -e "\n${amarillo}Clonando repositorio${reset}"
git clone "${repositorio}"
echo -e "${verde}Repositorio clonado.${reset}"

echo -e "\n${amarillo}Moviendo repositorio hacia la carpeta del servidor${reset}"
sudo mv "${carpeta}" /var/www/html

echo -e "\n${amarillo}Cambiando permisos de lectura y escritura a la carpeta ${carpeta}${reset}"
cd /var/www/html
sudo chown -R www-data "${carpeta}"


echo -e "\n${verde}Hemos terminado, ahora puede revisar el funcionamiento de su servidor.${reset}"
echo -e "\n${verde}direccionip/${carpeta}.${reset}"


