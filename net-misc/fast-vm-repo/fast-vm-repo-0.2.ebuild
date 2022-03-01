# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bash-completion-r1

DESCRIPTION="Script for listing and importing fast-vm images from repositories."
HOMEPAGE="https://github.com/OndrejHome/fast-vm-repo"
SRC_URI="https://github.com/OndrejHome/fast-vm-repo/archive/${PV}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+public-repositories"

# built time dependencies
DEPEND=""
# runtime dependencies
RDEPEND="
	sys-apps/gawk
	sys-apps/coreutils
	sys-apps/sed
	dev-libs/libxml2
	dev-libs/libxslt
	net-misc/curl
"

src_compile() {
	return
}

src_install() {
	dobin fast-vm-repo

	insinto /usr/share/fast-vm-repo/
	doins ${WORKDIR}/fast-vm-repo-${PV}/repository-sample.xml
	doins ${WORKDIR}/fast-vm-repo-${PV}/repository-sample.repo

	insinto /usr/share/fast-vm-repo/xslt/
	doins ${WORKDIR}/fast-vm-repo-${PV}/xslt/process_image_detail.xml
	doins ${WORKDIR}/fast-vm-repo-${PV}/xslt/process_image_list.xml

	newbashcomp ${WORKDIR}/fast-vm-repo-${PV}/fast-vm-repo.bash_completion fast-vm-repo

	dodoc README.md
	doman man/fast-vm-repo.8

	if use public-repositories ; then
		insinto /etc/fast-vm.repos.d/
		doins ${WORKDIR}/fast-vm-repo-${PV}/repos.d/*repo
	else
		keepdir /etc/fast-vm.repos.d/
	fi
}
