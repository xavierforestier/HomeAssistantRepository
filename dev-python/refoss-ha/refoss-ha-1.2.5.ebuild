# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi
DESCRIPTION="Refoss to support for Home Assistant"
HOMEPAGE="https://github.com/ashionky/refoss_ha https://pypi.org/project/refoss-ha/"

SRC_URI="$(pypi_wheel_url)"
S=${WORKDIR}

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

python_compile() {
	distutils_wheel_install "${BUILD_DIR}/install" "${DISTDIR}/${P/-/_}-py3-none-any.whl"
}
