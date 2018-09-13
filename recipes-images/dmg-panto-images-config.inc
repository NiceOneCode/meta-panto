DESCRIPTION = "DMG images base configs"

LICENSE = "CLOSED"

inherit core-image

# add remote debugging missing subprocess (https://community.freescale.com/thread/309578)
# TOOLCHAIN_HOST_TASK_append = " nativesdk-python-subprocess "

EXTRA_IMAGE_FEATURES = " debug-tweaks ssh-server-openssh tools-debug package-management "
# EXTRA_IMAGE_FEATURES   = "debug-tweaks ssh-server-openssh package-management"
# EXTRA_IMAGE_FEATURES += " eclipse-debug "
# EXTRA_IMAGE_FEATURES = " debug-tweaks "
# EXTRA_IMAGE_FEATURES += " ssh-server-openssh"
# EXTRA_IMAGE_FEATURES += " tools-debug "
# EXTRA_IMAGE_FEATURES += " package-management "
# EXTRA_IMAGE_FEATURES += " tools-sdk "


# EXTRA_IMAGE_FEATURES += " dbg-pkgs "
# EXTRA_IMAGE_FEATURES += " dev-pkgs "
# EXTRA_IMAGE_FEATURES += " ptest-pkgs "
# EXTRA_IMAGE_FEATURES += " tools-profile "
# EXTRA_IMAGE_FEATURES += " tools-testapps "

# EXTRA_IMAGE_FEATURES = " debug-tweaks ssh-server-openssh tools-debug "


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
    dmg-common-scripts \
    dmg-exe \
    dmg-base-scripts \
	packagegroup-qt5-qtcreator-debug \
    fftwf \
    openssh-sftp-server \
    p7zip \
    zip \
    unzip \
    dhcp-client \
    opkg \
    opkg-utils \
  procps \
"
# packagegroup-qt5-qtcreator-debug

IMAGE_INSTALL_remove ="qt3d nativesdk-qt3d qt3d-native ruby-native"
