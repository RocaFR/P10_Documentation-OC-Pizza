## 🌐 Configuration du serveur web
Se connecter en utilisant les identifiants renseignés lors de l'installation

Mettre à jour le système

    sudo apt update && sudo apt upgrade -y

Saisir son mot de passe et valider avec entrée

Installation du serveur web

    sudo apt install -y apache2
💡 Pour stopper le serveur web

    sudo systemctl stop apache2.service

💡 Pour démarrer la serveur web

    sudo systemctl start apache2.service

Création du dossier contenant le site web client

    sudo mkdir /var/www/ocpizza

Création du dossier contenant le site web du staff

    sudo mkdir /var/www/ocpizza-management

Clonage du repository du site client

    cd /var/www/ocpizza
    sudo git clone https://github.com/OC-Pizza/OC-Pizza.git

Clonage du repository du site staff

    cd ../ocpizza-management
    sudo git clone https://github.com/OC-Pizza/OC-Pizza-Management.git

Configurer le VHOST pour oc-pizza.com

    cd /etc/apache2/sites-available/
    sudo cp 000-default.conf ocpizza.conf
    sudo nano ocpizza.conf
Renseigner ServerAdmin

    webmaster@oc-pizza.com

Renseigner DocumentRoot

    /var/www/ocpizza/OC-Pizza/

Renseigner ServerName

    oc-pizza.com

Configurer le VHOST pour management.oc-pizza.com

    sudo cp ocpizza.conf ocpizza-management.conf
    sudo nano ocpizza-management.conf

Renseigner ServerAdmin

    webmaster@oc-pizza.com

Renseigner DocumentRoot

    /var/www/ocpizza-management/OC-Pizza-Management

Renseigner ServerName

    management.oc-pizza.com

Activer les VHOSTs

    sudo a2ensite ocpizza.conf ocpizza-management.conf

Prendre en compte les VHOSTs

    sudo systemctl reload apache2.service

## 🗄️ Configuration de la base de données
    sudo apt install -y postgresql-12
Télécharger le script de création de la base de données  

    wget -L bit.ly/3w91E99 -O script.sql
Création de la base de données 

    sudo -i -u postgres
    cat /home/oc/script.sql | psql

💡 Pour stopper la base de données

    sudo systemctl stop postgresql

💡 Pour démarrer la base de données

    1. sudo systemctl start postgresql


## 💾 Configuration du backup avec rsync

Récupération du script de configuration du backup

    cd
    wget -L https://tinyurl.com/p5mmvjhe -O configure_backup.sh
    chmod +x configure_backup.sh

## 📖 Configuration du monitoring avec Nagios
### Installer Nagios
    cd
    wget https://assets.nagios.com/downloads/nagiosxi/install.sh
    chmod +x install.sh
    sudo ./install.sh

Configurer Nagios
1. Se rendre à l'adresse indiquée en fin d'installation par exemple http://management.oc-pizza.com/nagiosxi/
2. Se laisser guider lors de l'installation (langue, identifiants et thème)
3. Accepter la licence
6. Pour configurer en profondeur le monitoring, se reporter à la documentation officielle : [Nagios XI Guide](https://assets.nagios.com/downloads/nagiosxi/guides/user/index.php)

---

<h1 align="center"> Félicitations, tout est en ligne ! 👏</h1>
<p align="center">
👉 <a href="oc-pizza.com">oc-pizza.com</a><br>
👉 <a href="management.oc-pizza.com">management.oc-pizza.com</a>
</p>