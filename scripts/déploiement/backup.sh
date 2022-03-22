#!/bin/bash

sudo systemctl stop postgresql
sudo rsync -arR --delete --files-from=/home/oc/.files_to_backup.txt / /home/oc/backup/
sudo systemctl start postgresql