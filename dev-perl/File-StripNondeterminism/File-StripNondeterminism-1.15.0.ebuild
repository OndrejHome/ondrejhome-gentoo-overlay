# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit perl-module

DESCRIPTION="file non-deterministic information stripper"
SRC_URI="https://salsa.debian.org/reproducible-builds/strip-nondeterminism/-/archive/1.15.0/strip-nondeterminism-1.15.0.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}"

S="${WORKDIR}/strip-nondeterminism-${PV}"
