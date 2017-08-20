# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGIT_REPO_URI="https://github.com/ClusterLabs/fence-virt"
EGIT_COMMIT="30baac19abe8858abd5db49edccd9bacd6bfdc8a"
inherit git-r3
SRC_URI=""

DESCRIPTION="Fencing agent for virtual machines."
HOMEPAGE="http://fence-virt.sourceforge.net"

LICENSE="GPLv2+"
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
