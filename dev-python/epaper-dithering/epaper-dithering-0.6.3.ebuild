# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Dithering algorithms for e-paper/e-ink displays"
HOMEPAGE="https://github.com/OpenDisplay/epaper-dithering https://pypi.org/project/epaper-dithering"
SRC_URI="https://github.com/OpenDisplay/epaper-dithering/archive/refs/tags/python-v${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/pillow-10.0.0[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.24.0[${PYTHON_USEDEP}]
"

src_unpack() {
	default
	mv "${WORKDIR}/epaper-dithering-python-v${PV}/packages/python" "${WORKDIR}/epaper_dithering-${PV}"
	rm "${WORKDIR}/epaper-dithering-python-v${PV}" -r
}

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
