# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/ClusterLabs/fence-virt"
EGIT_COMMIT="c2ca768a8e57a73b5ec2899305439122285aa4a9"
inherit git-r3
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

src_configure() {
	./autogen.sh
	econf
}

src_compile() {
	emake all
}
