1. Use official installer ISO
================================

With archlinux-20xx-core-i686.iso, you have several choices:

    *   **burn** it onto CD, then boot from CD-ROM

    *   **copy** it onto USB stick, then boot from USB stick ::

            dd if=archlinux-20xx-core-i686.iso of=/dev/sdX

    *   use grub2 to boot from ISO on disk ::

            menuentry "ArchISO" {
            insmod loopback
            loopback loop (hd0,msdos10)/iso/archlinux-20xx-i686-core.iso
            set root=(loop)
            linux   /boot/vmlinuz26 \
                    img_dev=/dev/sda10 \
                    img_loop=/iso/archlinux-20xx-i686-core.iso  \
                    quiet
            initrd /boot/archiso.img
            }

2. Use pacman in the coolest way
================================

pacman provide the `--root` option to specify where the root path is.

You can install arch from current Linux in only a few steps ::

    mkfs.ext4 /dev/sda5
    mkdir /mnt/arch
    mount -t ext4 /dev/sda5/ /mnt/arch
    mkdir -p /mnt/arch/var/lib/pacman
    pacman -r /mnt/arch -Syy
    pacman -r /mnt/arch -S base

You still need to customize `rc.conf` and make it **bootable** from grub2.

3. Using un-official archboot
==============================




