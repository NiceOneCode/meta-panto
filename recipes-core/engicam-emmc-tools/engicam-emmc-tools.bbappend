FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
PR="r1"

SRC_URI_append = " \
    file://emmc_fs_ker_dtb_N1C.sh \
		 "

do_install_append () {
	install -m 0755 ${WORKDIR}/emmc_fs_ker_dtb_N1C.sh ${D}${bindir}/emmc_fs_ker_dtb_N1C.sh
}
