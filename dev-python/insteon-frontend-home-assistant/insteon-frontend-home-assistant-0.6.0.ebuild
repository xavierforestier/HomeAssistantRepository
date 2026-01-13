# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
inherit distutils-r1

DESCRIPTION="The Insteon frontend for Home Assistant"
HOMEPAGE="https://github.com/pyinsteon/insteon-panel https://pypi.org/project/insteon-frontend-home-assistant/"

MY_PN="insteon-panel"
MY_PV="2025.12.19.154216"
SRC_URI="https://github.com/pyinsteon/${MY_PN}/archive/refs/tags/${MY_PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${MY_PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
DOCS="README.md"
