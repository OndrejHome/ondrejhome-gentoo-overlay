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
IUSE="acl snmp static-libs systemd hardened"

DEPEND="${PYTHON_DEPS}
	app-text/docbook-xsl-stylesheets
	dev-libs/libxslt
	sys-cluster/cluster-glue
	>=sys-cluster/libqb-0.14.0
	sys-cluster/resource-agents
	>=sys-cluster/corosync-3.0
	snmp? ( net-analyzer/net-snmp )
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
	# appends lib to localstatedir automatically
	econf \
		--libdir=/usr/$(get_libdir) \
		--localstatedir=/var \
		--disable-dependency-tracking \
		--disable-fatal-warnings \
		--with-corosync \
		--without-nagios \
		--disable-upstart \
		--without-profiling \
		--without-coverage \
		--with-configdir=/etc/pacemaker \
		$(use_enable systemd) \
		$(use_with hardened hardening) \
		$(use_with acl) \
		$(use_with snmp) \
		$(use_enable static-libs static)
}

src_install() {
	default
	rm -rf "${D}"/etc/init.d
	# TODO pacemaker_remote init.d/openrc files
	newinitd "${FILESDIR}/${PN}.initd" ${PN} || die
	# remove tests - TODO make into variable
	rm -rf "${D}"/usr/share/pacemaker/tests
	# copy sysconfig files to /etc/pacemaker
	cp -a "${S}/daemons/pacemakerd/pacemaker.sysconfig" "${D}/etc/pacemaker/pacemaker"
	cp -a "${S}/tools/crm_mon.sysconfig" "${D}/etc/pacemaker/crm_mon"
}
