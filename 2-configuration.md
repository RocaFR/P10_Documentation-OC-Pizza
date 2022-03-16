## Configuration du serveur web
1. Se connecter en utilisant les identifiants renseignés lors de l'installation
1. Mettre à jour le système
    1. sudo apt update && sudo apt upgrade -y
1. Saisir son mot de passe et valider avec entrée
1. Installation du serveur web
    1. sudo apt install -y apache2
1. Pour stopper le serveur web
    1. sudo systemctl stop apache2.service
1. Pour démarrer la serveur web
    1. sudo systemctl start apache2.service
1. Création du dossier contenant le site web client
    1. sudo mkdir /var/www/ocpizza
1. Création du dossier contenant le site web du staff
    1. sudo mkdir /var/www/ocpizza-management
1. Clonage du repository du site client
    1. cd /var/www/ocpizza
    1. sudo git clone https://github.com/OC-Pizza/OC-Pizza.git
1. Clonage du repository du site staff
    1. cd ../ocpizza-management
    1. sudo git clone https://github.com/OC-Pizza/OC-Pizza-Management.git
1. Configurer le VHOST pour oc-pizza.com
    1. cd /etc/apache2/sites-available/
    1. sudo cp 000-default.conf ocpizza.conf
    1. sudo nano ocpizza.conf
        1. Renseigner ServerAdmin
            1. webmaster@oc-pizza.com
        1. Renseigner DocumentRoot
            1. /var/www/ocpizza/OC-Pizza/
        1. Renseigner ServerName
            1. oc-pizza.com
1. Configurer le VHOST pour management.oc-pizza.com
    1. sudo cp ocpizza.conf ocpizza-management.conf
    1. sudo nano ocpizza-management.conf
        1. Renseigner ServerAdmin
            1. webmaster@oc-pizza.com
        1. Renseigner DocumentRoot
            1. /var/www/ocpizza-management/OC-Pizza-Management
        1. Renseigner ServerName
            1. management.oc-pizza.com ocpizza-management.conf
1. Activer les VHOSTs
    1. sudo a2ensite ocpizza.conf ocpizza-management.conf
1. Prendre en compte les VHOSTs
    1. sudo systemctl reload apache2.service

## Configuration de la base de données
1. sudo apt install -y postgresql-12
1. Télécharger le script de création de la base de données
    1. wget -L bit.ly/3w91E99 -O script.sql
1. Création de la base de données 
    1. sudo -i -u postgres
    1. cat /home/oc/script.sql | psql
1. Pour stopper la base de données
    1. sudo systemctl stop postgresql
1. Pour démarrer la base de données
    1. sudo systemctl start postgresql