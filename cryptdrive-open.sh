#!/bin/bash
KEY = ""

echo "Enter key to unlock crypdrive"
read -s KEY

echo -n $KEY | cryptsetup luksOpen /dev/sda1 cryptdrive -d -

mount /dev/mapper/cryptdrive /mnt/cryptdrive

