#!/bin/bash

echo "Téléchargement du script de backup..."
wget -L https://raw.githubusercontent.com/RocaFR/P10_Documentation-OC-Pizza/main/backup.sh?token=GHSAT0AAAAAABQXT7UZFUDIGQ4A6KUYPKF2YRTOI6Q -O .backup.sh
wget -L https://raw.githubusercontent.com/RocaFR/P10_Documentation-OC-Pizza/main/.files_to_backup.txt?token=GHSAT0AAAAAABQXT7UZZDCTY2WNNDUDX2VGYRTO4PQ -O .files_to_backup.txt
chmod +x .backup.sh

echo "Configuration du cron..."
echo "0 3 * * * /home/oc/.backup.sh" >> cron
sudo crontab cron

echo "Nettoyage du script..."
rm cron
rm $0