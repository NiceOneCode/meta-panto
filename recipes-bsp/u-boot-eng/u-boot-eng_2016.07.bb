# Copyright (C) 2012-2014 O.S. Systems Software LTDA.
# Released under the MIT license (see COPYING.MIT for the terms)

require recipes-bsp/u-boot/u-boot.inc

DESCRIPTION = "U-Boot based on mainline U-Boot used by FSL Community BSP in \
order to provide support for some backported features and fixes, or because it \
was submitted for revision and it takes some time to become part of a stable \
version, or because it is not applicable for upstreaming."
LICENSE = "GPLv2+"
LIC_FILES_CHKSUM = "file://Licenses/README;md5=a2c678cfd4a4d97135585cad908541c6"

PROVIDES += "u-boot"

SRC_URI = " \
    git://github.com/engicam-stable/u-boot-eng-2016.07.git;protocol=git;branch=som_release \
    file://0003-disabilitazione-autonegoziazione-u-boot.patch \
    file://0004-Panto-board-Device-tree.patch \
    file://icoremx6qd_panto_emmc_defconfig \
    file://icoremx6qd_panto_sd_defconfig \
    file://icoremx6qd_panto_nand_defconfig \
    "

SRCREV = "0526cd3a2a54cd0e916a26135b3454f9857ce83b"

S = "${WORKDIR}/git"

inherit fsl-u-boot-localversion

PACKAGE_ARCH = "${MACHINE_ARCH}"
COMPATIBLE_MACHINE = "(mx6|mx6ul)"

do_patch_prepend() {
    os.system("mv ${S}/../Engicam.bmp ${S}/tools/logos/");
}

do_configure_prepend(){
                   
  cp -f ${WORKDIR}/icoremx6qd_panto_emmc_defconfig  ${WORKDIR}/git/configs/
  echo "CONFIG_SYS_EXTRA_OPTIONS=\"IMX_CONFIG=board/engicam/icorem6/icorem6q.cfg,MX6Q,SYS_BOOT_EMMC,FDT_FILE="${KERNEL_DEVICETREE}"\"" >> ${WORKDIR}/git/configs/icoremx6qd_panto_emmc_defconfig 
  
  cp -f ${WORKDIR}/icoremx6qd_panto_sd_defconfig    ${WORKDIR}/git/configs/
  echo "CONFIG_SYS_EXTRA_OPTIONS=\"IMX_CONFIG=board/engicam/icorem6/icorem6q.cfg,MX6Q,ENV_IS_IN_MMC,FDT_FILE="${KERNEL_DEVICETREE}"\"" >> ${WORKDIR}/git/configs/icoremx6qd_panto_sd_defconfig 
 
  cp -f ${WORKDIR}/icoremx6qd_panto_nand_defconfig    ${WORKDIR}/git/configs/
  echo "CONFIG_SYS_EXTRA_OPTIONS=\"IMX_CONFIG=board/engicam/icorem6/icorem6q.cfg,MX6Q,ENV_IS_IN_NAND,SYS_BOOT_NAND,FDT_FILE="${KERNEL_DEVICETREE}"\"" >> ${WORKDIR}/git/configs/icoremx6qd_panto_nand_defconfig 
}



