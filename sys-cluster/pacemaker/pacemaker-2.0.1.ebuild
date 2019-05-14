# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 python3_{5,6,7} )

inherit autotools eutils python-single-r1

MY_PN="Pacemaker"
MY_P=${MY_PN}-${PV/_/-}

DESCRIPTION="Pacemaker CRM"
HOMEPAGE="http://www.linux-ha.org/wiki/Pacemaker"
SRC_URI="https://github.com/ClusterLabs/${PN}/archive/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="acl static-libs systemd hardened nagios"

DEPEND="${PYTHON_DEPS}
	app-text/docbook-xsl-stylesheets
	dev-libs/libxslt
	sys-cluster/cluster-glue
	>=sys-cluster/libqb-0.14.0
	>=sys-cluster/corosync-3.0
"
RDEPEND="${DEPEND}"

REQUIRED_USE=${PYTHON_REQUIRED_USE}

S="${WORKDIR}/${PN}-${MY_P}"

src_prepare() {
	default
	sed -i -e "s/ -ggdb//g" configure.ac || die
	eautoreconf
}

src_configure() {
	econf \
		--libdir=/usr/$(get_libdir) \
		--localstatedir=/var \
		--disable-dependency-tracking \
		--disable-fatal-warnings \
		--with-corosync \
		--disable-upstart \
		--without-profiling \
		--without-coverage \
		--with-configdir=/etc/default \
		$(use_with nagios) \
		$(use_enable systemd) \
		$(use_with hardened hardening) \
		$(use_with acl) \
		$(use_enable static-libs static)
}

src_install() {
	default
	# delete the provided initd files and use openRC versions
	rm -rf "${D}"/etc/init.d
	# TODO 'pacemaker_remote' openRC file
	# TODO 'crm_mon' openRC file
	newinitd "${FILESDIR}/${PN}.initd" ${PN} || die
	# copy sysconfig files to /etc/default
	insinto /etc/default
	newins "${S}/daemons/pacemakerd/pacemaker.sysconfig" "pacemaker"
	newins "${S}/tools/crm_mon.sysconfig" "crm_mon"
}
}
