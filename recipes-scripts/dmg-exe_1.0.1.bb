DESCRIPTION = "DMG exe file"

LICENSE = "GPLv2+"
LIC_FILES_CHKSUM = "file://${WORKDIR}/LICENSE;md5=2d04528cdadb070b355f9176c1149f90"

SECTION = "base"

PR = "r1"

SRC_URI = "file://*"

RDEPENDS_${PN} = "bc bash"

BBFILE_PRIORITY = "1"


FILES_${PN}=" /home \
              /home/root \
              /home/root/PantoEmu \
              /home/root/configPantoEMU.xml \
              /home/root/IPTComConfigPantoEMU.xml \
              /home/root/PantoLog.ini \
              /home/root/Sollevamenti.txt \
              /home/root/KmPercorsi.txt \
              /etc \
              /etc/init.d/ \
              /etc/init.d/PantoEmu.sh \
"

do_install[nostamp]="1"

do_install () {

      install -d  ${D}/home
      install -d  ${D}/home/root
      install -d ${D}${sysconfdir}/init.d

      install -m 0777 ${WORKDIR}/PantoEmu                    ${D}/home/root/
      install -m 0777 ${WORKDIR}/CfgFilePantoEMU.xml         ${D}/home/root/
      install -m 0777 ${WORKDIR}/IPTComConfigPantoEMU.xml    ${D}/home/root/
      install -m 0777 ${WORKDIR}/PantoLog.ini                ${D}/home/root/
      install -m 0777 ${WORKDIR}/Sollevamenti.txt            ${D}/home/root/
      install -m 0777 ${WORKDIR}/KmPercorsi.txt              ${D}/home/root/

      install -d  ${D}/etc
      install -m 0777 ${WORKDIR}/PantoEmu.sh                 ${D}${sysconfdir}/init.d/
      update-rc.d -r ${D} PantoEmu.sh                        start 99 5 .



}
