# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

AUTOTOOLS_AUTORECONF=1

inherit autotools-utils

DESCRIPTION="Kronosnet (knet) - network abstraction layer for High Availability use cases"
HOMEPAGE="https://kronosnet.org/"
SRC_URI="https://github.com/kronosnet/kronosnet/archive/v${PV}.tar.gz  -> ${P}.tar.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="docs sctp lzo +nss openssl +zlib +lz4 +bzip2"

DEPEND="${RDEPEND}
		docs? ( app-doc/doxygen )
"
RDEPEND="
		dev-libs/libnl:3
		lzo? ( dev-libs/lzo )
		sctp? ( net-misc/lksctp-tools )
		nss? ( dev-libs/nss )
		openssl? ( dev-libs/openssl:0 )
		zlib? ( sys-libs/zlib )
		lz4? ( app-arch/lz4 )
		bzip2? ( app-arch/bzip2 )
"
BDEPEND=""

src_prepare() {
	autotools-utils_src_prepare
}

src_configure() {
	local myeconfargs=(
			$(use_enable sctp libknet-sctp)
			$(use_enable zlib compress-zlib)
			$(use_enable lzo compress-lzo2)
			$(use_enable lz4 compress-lz4)
			$(use_enable bzip2 compress-bzip2)
			$(use_enable nss crypto-nss)
			$(use_enable openssl crypto-openssl)
			$(use_enable docs man)
	)
	autotools-utils_src_configure
}

src_compile() {
	autotools-utils_src_compile
}

src_install() {
	autotools-utils_src_install
}
