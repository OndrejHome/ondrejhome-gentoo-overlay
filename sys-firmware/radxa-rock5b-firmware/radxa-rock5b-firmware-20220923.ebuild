# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Firmware for MALI G610 GPU found on Radxa ROCK5B boards"
HOMEPAGE="https://github.com/JeffyCN/rockchip_mirrors/tree/libmali"
SRC_URI="https://github.com/JeffyCN/rockchip_mirrors/raw/3d4d26fb997fa9acbe0aab54e819baa7161d94d9/firmware/g610/mali_csffw.bin https://raw.githubusercontent.com/JeffyCN/rockchip_mirrors/3d4d26fb997fa9acbe0aab54e819baa7161d94d9/END_USER_LICENCE_AGREEMENT.txt"

LICENSE="Mali-DRIVER-EULA"
SLOT="0"
KEYWORDS="arm64"

# built time dependencies
DEPEND=""
# runtime dependencies
RDEPEND=""

src_unpack() {
	mkdir ${WORKDIR}/${P}
	cp ${DISTDIR}/mali_csffw.bin  ${WORKDIR}/${P}
	cp ${DISTDIR}/END_USER_LICENCE_AGREEMENT.txt  ${WORKDIR}/${P}
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
