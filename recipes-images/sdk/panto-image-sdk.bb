DESCRIPTION = "Dmg sdk image recipe"

require ../dmg-panto-images-config.inc

inherit populate_sdk_base
inherit populate_sdk_${@base_contains('MACHINE', 'dmg6d', 'dmg-qt5_geam6ul', 'dmg-qt5_icore', d)}


export IMAGE_BASENAME_mx6d = "dmg-panto-sdk-imx6d"

SDKIMAGE_FEATURES = "dev-pkgs dbg-pkgs staticdev-pkgs"

IMAGE_INSTALL_append = " \
	glibc-staticdev \
 "

IMAGE_INSTALL_remove ="qt3d nativesdk-qt3d qt3d-native ruby-native"
