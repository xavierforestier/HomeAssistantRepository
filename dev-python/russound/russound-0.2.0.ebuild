# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Python API for Russound RNET commands."
HOMEPAGE="https://github.com/laf/russound https://pypi.org/project/russound/"

# No SDIST, no tag for 0.2.0
COMMIT="ce75833771661e1c855b6ce0fe1504bfc84291d6"
SRC_URI="https://github.com/laf/russound/archive/${COMMIT}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

DOCS="README.md"

RDEPEND="dev-python/requests[${PYTHON_USEDEP}]"

distutils_enable_tests pytest