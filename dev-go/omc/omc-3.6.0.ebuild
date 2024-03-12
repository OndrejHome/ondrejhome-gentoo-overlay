# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module

DESCRIPTION="OpenShift Must-Gather Client"
HOMEPAGE="https://github.com/gmeghnag/omc.git"
SRC_URI="https://github.com/gmeghnag/omc/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="dev-lang/go"

src_compile() {
		GOBIN="${S}/bin" go install
}

src_install() {
		dobin bin/${PN}
}
