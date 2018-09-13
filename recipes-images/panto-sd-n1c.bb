DESCRIPTION = "DMG Diner image base for SD geam6ul"

export IMAGE_BASENAME = "dmg-SD-filesystem-primary"
export IMAGE_NAME     =  "${MACHINE}-SD-filesystem-primary"

LICENSE = "MIT"

inherit core-image

EXTRA_IMAGE_FEATURES = " debug-tweaks ssh-server-openssh package-management tools-debug "

IMAGE_INSTALL_append_mx6 = " \
	firmware-imx-vpu-imx6q \
	firmware-imx-vpu-imx6d \
	imx-test \
"
 
IMAGE_INSTALL_append = " \
	binutils \
	engicam-emmc-tools \
	iproute2 \
	canutils \
	mtd-utils \
	mtd-utils-ubifs \
	devmem2 \
	i2c-tools \
	imx-kobs \
	fw-nandautosize \
	minicom \
	ethtool \
	net-tools \
	dosfstools \
	e2fsprogs \
	usbutils \
	cpufrequtils \
"

#DMG PACKAGES
IMAGE_INSTALL_append = " \
	dmg-sd-scripts\
    openssh-sftp-server \
	dhcp-client \
    opkg \
    opkg-utils \
"
# packagegroup-qt5-qtcreator-debug

IMAGE_INSTALL_remove ="qt3d nativesdk-qt3d qt3d-native ruby-native"


