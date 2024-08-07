# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=8

inherit linux-info

DESCRIPTION="Script for defining VMs from images provided in thin LVM pool"
HOMEPAGE="https://www.famera.cz/blog/fast-vm/about.html"

inherit git-r3
EGIT_REPO_URI="https://github.com/ondrejhome/fast-vm.git"
SRC_URI=""
EGIT_BRANCH="master"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS=""
IUSE="+hack-file-dependencies +bash-completion +zstd"

# built time dependencies
DEPEND=""
# runtime dependencies
RDEPEND="
	app-emulation/libvirt[virt-network]
	net-dns/dnsmasq[dhcp-tools,script]
	sys-apps/gawk
	sys-apps/coreutils
	app-admin/sudo
	dev-libs/libxml2
	sys-fs/lvm2[thin]
	net-misc/openssh
	net-misc/sshpass
	|| ( net-misc/curl net-misc/wget )
	hack-file-dependencies? (
		>=app-emulation/libguestfs-1.36.4
		>=app-emulation/libguestfs-appliance-1.36.1
		app-emulation/libvirt[virt-network,qemu]
		)
	bash-completion? ( app-shells/bash-completion )
	zstd? ( app-arch/zstd )
"

src_compile() {
	return
}

pkg_setup() {
	# check if some basic kernel modules not checked elsewhere are needed
	CONFIG_CHECK="
		~DM_SNAPSHOT
		~DM_THIN_PROVISIONING
		~CONFIG_NF_NAT_IPV4
		~CONFIG_NF_NAT_MASQUERADE_IPV4"
	if [[ -n ${CONFIG_CHECK} ]]; then
                linux-info_pkg_setup
        fi
}
