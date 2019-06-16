# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_6 )
#inherit distutils-r1
inherit python-utils-r1 systemd

DESCRIPTION="Pacemaker/Corosync Configuration System"
HOMEPAGE="https://github.com/ClusterLabs/pcs"
SRC_URI="https://github.com/ClusterLabs/pcs/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="snmp systemd"

DEPEND="media-libs/fontconfig
	dev-ruby/bundler
	dev-lang/ruby:2.4
	dev-python/pycurl
	dev-python/lxml
	dev-python/pyopenssl
	dev-ruby/ethon
"
RDEPEND="${DEPEND}
	www-servers/tornado
	dev-ruby/tilt
	dev-ruby/sinatra
	dev-ruby/open4
	dev-ruby/backports
	sys-libs/pam
	>=sys-cluster/pacemaker-2.0
"
BDEPEND=""

REQUIRED_USE=${PYTHON_REQUIRED_USE}

PATCHES=( "${FILESDIR}/remove-ruby-bundle-path.patch" "${FILESDIR}/openrc.patch" )

src_compile() {
	return
}

src_install() {
	# pre-create directory that is needed by 'make install'
	dodir "/usr/lib/pcs"
	# install files using 'make install'
	emake install \
		SYSTEMCTL_OVERRIDE=$(use systemd) \
		DESTDIR="${D}" \
		CONF_DIR="/etc/default/" \
		PREFIX="/usr${EPREFIX}" \
		BUNDLE_INSTALL_PYAGENTX=false \
		BUNDLE_TO_INSTALL=false \
		BUILD_GEMS=false

	# mark log directories to be kept
	keepdir /var/log/pcsd
	keepdir /var/lib/pcsd

	# symlink the /usr/lib/pcs/pcs to /usr/sbin/pcs for pcsd
	dosym /usr/sbin/pcs "${EPREFIX}/usr/lib/pcs/pcs"

	# use Debian style systemd unit (with config in /etc/default/pcsd)
	cp -a "${S}/pcsd/pcsd.service.debian" "${D}/usr/lib/systemd/system/pcsd.service"
	# custom service file for openRC
	newinitd "${FILESDIR}/pcsd.initd" pcsd || die

	# move config files to right places - we use debian-style /etc/default
	cp -a "${S}/pcs/settings.py.debian" "${D}/usr/lib/pcs/settings.py"
	cp -a "${S}/pcsd/settings.rb.debian" "${D}/usr/lib/pcsd/settings.rb"

	# unless support for SNMP was requested remove SNMP related files
	if ! use snmp; then
		rm -rf "${D}/usr/share/snmp"
		rm -rf "${D}/usr/lib64/python*/site-packages/pcs/snmp" #FIXME
		rm "${D}/usr/share/man/man8/pcs_snmp_agent.8"
		rm "${D}/usr/lib/systemd/system/pcs_snmp_agent.service"
		rm "${D}/usr/lib/pcs/pcs_snmp_agent"
		rm "${D}/etc/default/pcs_snmp_agent"
	fi
}
