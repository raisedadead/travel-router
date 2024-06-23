#!/bin/sh

# Log the start of the script
echo "Running first_boot.sh script" >/var/log/first_boot.log

# Execute the expand_root.sh script
sh /usr/local/bin/expand_root.sh >>/var/log/first_boot.log 2>&1

# Log the completion of the script
echo "Completed first_boot.sh script" >>/var/log/first_boot.log
reboot
