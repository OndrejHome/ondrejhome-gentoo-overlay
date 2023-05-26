# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_11 )
inherit distutils-r1

DESCRIPTION="oc like tool that works with must-gather rather than OpenShift API"
HOMEPAGE="
	https://github.com/kxr/o-must-gather
	https://pypi.org/project/o-must-gather/
"
SRC_URI="https://github.com/kxr/o-must-gather/archive/refs/tags/v1.2.6.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64"

RDEPEND="
		dev-python/pyyaml
		!>dev-python/click-7.1.2
		dev-python/cffi
		dev-python/pycparser
		dev-python/cryptography
		dev-python/tabulate
"
BDEPEND="
		${RDEPEND}
"

#distutils_enable_tests pytest
