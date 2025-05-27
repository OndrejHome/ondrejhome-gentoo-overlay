# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module

DESCRIPTION="Dyff"
HOMEPAGE="https://github.com/homeport/dyff.git"
SRC_URI="https://github.com/homeport/dyff/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://kr.famera.cz/tmp/${P}-vendor.tar.gz -> ${P}-deps.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="dev-lang/go"

src_compile() {
		ego build -o dyff cmd/dyff/*.go
}

src_install() {
		dobin ${PN}
		dodoc README.md LICENSE
}
