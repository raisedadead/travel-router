#!/bin/sh

# Log the start of the expand_root.sh script
echo "Starting expand_root.sh script" >/var/log/expand_root.log

# Create 70-rootpt-resize script
cat <<'EOF' >/usr/local/bin/70-rootpt-resize
#!/bin/sh

exec >/var/log/70-rootpt-resize.log 2>&1

echo "Starting 70-rootpt-resize script"

if [ ! -e /etc/rootpt-resize-done ] && type parted > /dev/null && lock -n /var/lock/root-resize; then
    echo "Resizing root partition..."
    ROOT_BLK="$(readlink -f /sys/dev/block/"$(awk -e '$9=="/dev/root"{print $3}' /proc/self/mountinfo)")"
    ROOT_DISK="/dev/${ROOT_BLK%%[0-9]*}"
    ROOT_PART="${ROOT_BLK##*[^0-9]}"

    echo "ROOT_BLK: $ROOT_BLK"
    echo "ROOT_DISK: $ROOT_DISK"
    echo "ROOT_PART: $ROOT_PART"

    parted -f -s "${ROOT_DISK}" resizepart "${ROOT_PART}" 100%
    partprobe "${ROOT_DISK}"

    touch /etc/rootpt-resize-done
    echo "Root partition resized. Rebooting..."
    reboot
else
    echo "Root partition already resized or required tools not available."
fi
EOF

chmod +x /usr/local/bin/70-rootpt-resize
echo "Created and set permissions for 70-rootpt-resize" >>/var/log/expand_root.log

# Create 80-rootfs-resize script
cat <<'EOF' >/usr/local/bin/80-rootfs-resize
#!/bin/sh

exec >/var/log/80-rootfs-resize.log 2>&1

echo "Starting 80-rootfs-resize script"

if [ ! -e /etc/rootfs-resize-done ] && [ -e /etc/rootpt-resize-done ] && \
    type resize2fs > /dev/null && lock -n /var/lock/root-resize; then

    echo "Resizing root filesystem..."
    ROOT_BLK="$(readlink -f /sys/dev/block/"$(awk -e '$9=="/dev/root"{print $3}' /proc/self/mountinfo)")"
    ROOT_DEV="/dev/${ROOT_BLK##*/}"

    echo "ROOT_BLK: $ROOT_BLK"
    echo "ROOT_DEV: $ROOT_DEV"

    # Check filesystem before resizing
    e2fsck -f -y "${ROOT_DEV}"

    # Resize filesystem
    resize2fs "${ROOT_DEV}"

    # Reset mount count and disable auto fsck
    tune2fs -C 0 -c -1 -i 0 "${ROOT_DEV}"

    touch /etc/rootfs-resize-done
    echo "Root filesystem resized."

    # Force filesystem check on next boot
    touch /forcefsck

    echo "Rebooting to apply changes..."
    reboot
else
    echo "Root filesystem already resized or required tools not available."
fi
EOF

chmod +x /usr/local/bin/80-rootfs-resize
echo "Created and set permissions for 80-rootfs-resize" >>/var/log/expand_root.log

# Create an init.d script to manage the expansion process
cat <<'EOF' >/etc/init.d/manage-expansion
#!/bin/sh /etc/rc.common

START=99

start() {
    if [ ! -e /etc/expansion-completed ]; then
        echo "Running expansion process" >> /var/log/manage-expansion.log
        if [ ! -e /etc/rootpt-resize-done ]; then
            echo "Running 70-rootpt-resize" >> /var/log/manage-expansion.log
            /usr/local/bin/70-rootpt-resize
        elif [ ! -e /etc/rootfs-resize-done ]; then
            echo "Running 80-rootfs-resize" >> /var/log/manage-expansion.log
            /usr/local/bin/80-rootfs-resize
        else
            echo "Both expansion scripts have run successfully." >> /var/log/manage-expansion.log
            touch /etc/expansion-completed
        fi
    else
        echo "Expansion process already completed." >> /var/log/manage-expansion.log
    fi
}
EOF

chmod +x /etc/init.d/manage-expansion
echo "Created and set permissions for manage-expansion" >>/var/log/expand_root.log

# Enable the init.d service
/etc/init.d/manage-expansion enable
echo "Enabled manage-expansion service" >>/var/log/expand_root.log

# Log the completion of the expand_root.sh script
echo "expand_root.sh script completed" >>/var/log/expand_root.log
