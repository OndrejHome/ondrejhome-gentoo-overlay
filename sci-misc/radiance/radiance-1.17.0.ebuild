# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
ROCM_VERSION="7.2"

inherit cmake rocm

# https://codeberg.org/StillDeadcode/radiance/archive/v1.17.0.tar.gz

DESCRIPTION="Modular inference engine for people that want to get the most out of their hardware"
HOMEPAGE="https://codeberg.org/StillDeadcode/radiance"
SRC_URI="https://codeberg.org/StillDeadcode/radiance/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/radiance"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"

IUSE="ffmpeg"

DEPEND="
		>=dev-util/hip-${ROCM_VERSION}:=
		ffmpeg? ( media-video/ffmpeg )
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
		local mycmakeargs=(
		    -DRAD_WITH_HIP=ON
			-DRAD_GPU_TARGETS=$(get_amdgpu_flags)
			-DRAD_WITH_FFMPEG=$(usex ffmpeg "ON" "OFF")
		)
		cmake_src_configure
}
src_install() {
		cmake_src_install
}
