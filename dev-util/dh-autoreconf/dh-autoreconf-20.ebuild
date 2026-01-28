# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit perl-functions

DESCRIPTION="debhelper add-on to call autoreconf and clean up after the build"
HOMEPAGE="https://salsa.debian.org/debian/dh-autoreconf"
SRC_URI="http://deb.debian.org/debian/pool/main/d/dh-autoreconf/dh-autoreconf_20.tar.xz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64"

DEPEND="dev-lang/perl dev-util/debhelper"
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	perl_domodule -C Debian/Debhelper/Sequence autoreconf.pm
	dobin dh_autoreconf
	dobin dh_autoreconf_clean
	dodir /usr/share/dh-autoreconf
	insinto /usr/share/dh-autoreconf
	doins ltmain-as-needed.diff
	# FIXME autoreconf.mk       /usr/share/cdbs/1/rules
}
