#!/bin/bash

cat <<'EOF'

Assicurarsi che nella partizione dati (/dev/mmcblk0p3) della sd 
siano presenti i seguenti file, rinominati correttamente:

panto-imx6d-filesystem-primary.rootfs.tar.bz2..........rootfs.tar.bz2
u-boot-emmc-2016.07-r0.imx.............................u-boot-emmc.imx
u-boot-sd-2016.07-r0.imx...............................u-boot-sd.imx
uImage--4.1.15-r0-panto-imx6d-20170918121129.bin.......uImage
uImage--4.1.15-r0-panto-imx6d-20170918121129.dtb.......panto-imx6d.dtb  

ATTENZIONE: il modulo verrà formattato e riprogrammato in tutte le
sue parti: u-boot, kernel, device tree, filesystem

EOF


read -p "Procedere con la programmazione del modulo? (y/N) " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
fi    
    mount /dev/mmcblk0p3 /mnt
    cd /mnt
    /usr/bin/./emmc_fs_ker_dtb.sh /dev/mmcblk1 . panto-imx6d.dtb -p

    rm u-boot.imx
    cp u-boot-emmc.imx u-boot.imx
    /usr/bin/./emmc_boot.sh /dev/mmcblk1 . u-boot.imx





