# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_12 )

inherit distutils-r1 pypi

DESCRIPTION="test JIRA module"
HOMEPAGE="
	https://pypi.org/project/jira/
"
#SRC_URI="https://github.com/pycontribs/jira/archive/refs/tags/${PV}.tar.gz -> ${P}-${PV}.tar.gz"
SRC_URI="https://files.pythonhosted.org/packages/78/b4/557e4c80c0ea12164ffeec0e29372c085bfb263faad53cef5e1455523bec/jira-3.8.0.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
		dev-python/requests-toolbelt
		dev-python/typeguard
"
BDEPEND="
"

distutils_enable_tests pytest
