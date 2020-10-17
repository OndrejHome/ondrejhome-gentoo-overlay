# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="Checks ansible playbooks for practices and behaviour that can be improved"
HOMEPAGE="https://github.com/ansible/ansible-lint"
SRC_URI="https://github.com/ansible/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

CDEPEND="app-admin/ansible[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/six[${PYTHON_USEDEP}]
		dev-python/ruamel-yaml[${PYTHON_USEDEP}]"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		dev-python/setuptools-git[${PYTHON_USEDEP}]
		dev-python/setuptools_scm[${PYTHON_USEDEP}]
		dev-python/setuptools_scm_git_archive[${PYTHON_USEDEP}]
		dev-python/typing-extensions[${PYTHON_USEDEP}]
		test? (
			dev-python/flake8[${PYTHON_USEDEP}]
			dev-python/nose[${PYTHON_USEDEP}]
			dev-python/wheel[${PYTHON_USEDEP}]
		)
		${CDEPEND}"
RDEPEND="${CDEPEND}"

python_test() {
	nosetests || die
}
