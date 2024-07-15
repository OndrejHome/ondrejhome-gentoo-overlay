# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/ClusterLabs/fence-virt"
EGIT_COMMIT="370685ad523e8a724b8f4f312fe02c5085eda54f"
inherit git-r3 systemd
SRC_URI=""

DESCRIPTION="Fencing agent for virtual machines."
HOMEPAGE="http://fence-virt.sourceforge.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
		dev-libs/nss
		app-emulation/libvirt
"
RDEPEND="${DEPEND}"

PATCHES=("${FILESDIR}/001-do-not-generate-EnvironmentFile.patch")

src_configure() {
	./autogen.sh
	econf
}

src_install() {
	default
	systemd_dounit fence_virtd.service
	newinitd fence_virtd.init fence_virtd
}

src_compile() {
	emake all
}
