# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..14} )
DISTUTILS_USE_PEP517="setuptools"
inherit distutils-r1 systemd

DESCRIPTION="Command shell for managing Linux NVME kernel target"
HOMEPAGE="https://git.infradead.org/users/hch/nvmetcli.git"
SRC_URI="https://kr.famera.cz/large_files/nvmetcli-2026-07-13.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm arm64 ~loong ~mips ~ppc ~ppc64 ~riscv ~sparc ~x86"

RESTRICT="test"
RDEPEND="
	dev-python/configshell-fb[${PYTHON_USEDEP}]
	dev-python/pyparsing[${PYTHON_USEDEP}]"
S="${WORKDIR}/nvmetcli-2026-07-13"

src_install() {
	distutils-r1_src_install

	keepdir /etc/nvmet
	systemd_dounit nvmet.service
}
