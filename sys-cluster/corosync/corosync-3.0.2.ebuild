# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="OSI Certified implementation of a complete cluster engine"
HOMEPAGE="http://www.corosync.org/"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2 public-domain"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc static-libs systemd xml snmp watchdog nozzle"

# TODO: support those new configure flags
# --enable-augeas : Install the augeas lens for corosync.conf
RDEPEND="!sys-cluster/heartbeat
	sys-cluster/kronosnet
	nozzle? ( sys-cluster/kronosnet[libnozzle] )
	dev-libs/nss
	snmp? ( net-analyzer/net-snmp )
	>=sys-cluster/libqb-0.14.4"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( sys-apps/groff )"

PATCHES=( "${FILESDIR}/${PN}-3.0.1-docs.patch" )

DOCS=( README.recovery AUTHORS )

src_prepare() {
	default
	sed -i -e "s/ -ggdb3//g" configure.ac || die
	eautoreconf
}

src_configure() {
	default
	# appends lib to localstatedir automatically
	# FIXME: install just shared libs --disable-static does not work
	econf_opts=(
		--localstatedir=/var \
		--docdir=/usr/share/doc/${PF} \
		--with-initconfigdir=/etc/corosync \
		$(use_enable watchdog) \
		$(use_enable systemd) \
		$(use_enable snmp) \
		$(use_enable nozzle) \
		$(use_enable xml xmlconf)
	)
	use doc && econf_opts+=( --enable-doc )
	econf "${econf_opts[@]}"
}

src_install() {
	default
	newinitd "${FILESDIR}"/${PN}.initd ${PN}

	if use systemd; then
		rm "${D}"/lib/systemd/system/corosync-notifyd.service || die
	else
		rm "${D}"/etc/init.d/corosync-notifyd || die
	fi

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/${PN}.logrotate ${PN}

	keepdir /var/lib/corosync
	use static-libs || rm -rf "${D}"/usr/$(get_libdir)/*.{,l}a || die

	keepdir /var/log/cluster

	# copy sysconfig files to /etc/corosync
	cp -a "${S}/init/corosync.sysconfig.example" "${D}/etc/corosync/corosync"
}

pkg_postinst() {
	if [[ ${REPLACING_VERSIONS} < 3.0 ]]; then
		ewarn "!! IMPORTANT !!"
		ewarn " "
		ewarn "Migrating from a previous version of corosync can be dangerous !"
		ewarn " "
		ewarn "Make sure you backup your cluster configuration before proceeding"
		ewarn " "
	fi
}
