# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=standalone
inherit distutils-r1 pypi

DESCRIPTION="Python-base APIs and tools for CHIP."
HOMEPAGE="https://github.com/project-chip/connectedhomeip https://pypi.org/project/home-assistant-chip-clusters/"
SRC_URI="$(pypi_wheel_url)"
S=${WORKDIR}

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	dev-python/unicode-rbnf[${PYTHON_USEDEP}]
	~dev-python/aenum-3.1.15[${PYTHON_USEDEP}]
	dev-python/aiorun[${PYTHON_USEDEP}]
"

python_compile() {
	distutils_wheel_install "${BUILD_DIR}/install" "${DISTDIR}/${PN//-/_}-${PV}-py3-none-any.whl"
}
