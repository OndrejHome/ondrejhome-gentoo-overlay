# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module

DESCRIPTION="Kubectl plugin for comparing config and CRs with reference"
HOMEPAGE="https://github.com/openshift/kube-compare.git"
SRC_URI="https://github.com/openshift/kube-compare/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="dev-lang/go"

src_install() {
		dobin _output/bin/kubectl-cluster_compare
		dodoc README.md
		dodoc -r docs
}
