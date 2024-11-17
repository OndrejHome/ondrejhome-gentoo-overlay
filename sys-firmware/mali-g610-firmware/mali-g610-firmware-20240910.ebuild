# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Firmware for MALI G610 GPU found on Radxa ROCK5B boards"
HOMEPAGE="https://github.com/JeffyCN/mirrors/tree/libmali"
SRC_URI="https://github.com/JeffyCN/mirrors/raw/7f57be417a061b9e17126e30d3bddde62d38fa77/firmware/g610/mali_csffw.bin -> ${PV}-mali_csffw.bin
https://raw.githubusercontent.com/JeffyCN/mirrors/7f57be417a061b9e17126e30d3bddde62d38fa77/END_USER_LICENCE_AGREEMENT.txt -> ${PV}-END_USER_LICENCE_AGREEMENT.txt"

LICENSE="Mali-DRIVER-EULA"
SLOT="0"
KEYWORDS="~arm64"

# built time dependencies
DEPEND=""
# runtime dependencies
RDEPEND=""

src_unpack() {
	mkdir ${WORKDIR}/${P}
	cp ${DISTDIR}/${PV}-mali_csffw.bin  ${WORKDIR}/${P}/mali_csffw.bin
	cp ${DISTDIR}/${PV}-END_USER_LICENCE_AGREEMENT.txt  ${WORKDIR}/${P}/END_USER_LICENCE_AGREEMENT.txt
	return
}

src_compile() {
	return
}

src_install() {
	dodoc END_USER_LICENCE_AGREEMENT.txt
	insinto /lib/firmware
	doins mali_csffw.bin
}
