DESCRIPTION = "DMG common startup scripts"

LICENSE = "GPLv2+"
LIC_FILES_CHKSUM = "file://${WORKDIR}/LICENSE;md5=2d04528cdadb070b355f9176c1149f90"

SECTION = "base"

PR = "r1"

SRC_URI = "file://*"

RDEPENDS_${PN} = "bc bash"

BBFILE_PRIORITY = "1"

FILES_${PN}=" /etc \
              /home \
              /home/root \
              /home/root/prog-panto.sh \
"

do_install[nostamp]="1"

do_install () {
      install -d  ${D}/home
      install -d  ${D}/home/root

      install -d ${D}/etc
      install -d ${D}${sysconfdir}/init.d

      install -m 0755 ${WORKDIR}/dmg_ssh_check.sh                     ${D}${sysconfdir}/init.d/
      install -m 0755 ${WORKDIR}/dmg_ssh_key.sh                       ${D}${sysconfdir}/init.d/
      
      install -m 0755 ${WORKDIR}/prog-panto.sh                        ${D}/home/root

      update-rc.d -r ${D} dmg_ssh_check.sh                            start 98 5 .
}


pkg_postinst_${PN}() {
#!/bin/sh -e
if [ x"$D" = "x" ]; then
 sh /etc/init.d/dmg_ssh_check.sh 1
else
  exit 1
fi
}
