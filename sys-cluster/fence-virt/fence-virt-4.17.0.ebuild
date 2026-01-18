# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/ClusterLabs/fence-agents.git"
EGIT_COMMIT="v4.17.0"
inherit git-r3 systemd tmpfiles
SRC_URI=""

DESCRIPTION="Fencing agent for virtual machines."
HOMEPAGE="https://github.com/ClusterLabs/fence-agents.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND="
		dev-libs/nss
		app-emulation/libvirt
"
RDEPEND="${DEPEND}"

#PATCHES=("${FILESDIR}/001-do-not-generate-EnvironmentFile.patch")
PATCHES=(
	"${FILESDIR}"/001-do-not-generate-EnvironmentFile-v4.17.0.patch
	"${FILESDIR}"/002-disablepexpect-pycurl.patch 
	"${FILESDIR}"/003-remove-azure-snmp-fence.patch
)

src_configure() {
	./autogen.sh
	econf --with-agents="virt" --disable-cpg-plugin
}

src_install() {
	default
	systemd_dounit agents/virt/fence_virtd.service
	find "${ED}" -type f -name '*.la' -delete || die
	# FIXME openrc initd file
	#newinitd fence_virtd.init fence_virtd
}

src_compile() {
	emake all
}

pkg_postinst() {
	tmpfiles_process /usr/lib/tmpfiles.d/fence-agents.conf
}
