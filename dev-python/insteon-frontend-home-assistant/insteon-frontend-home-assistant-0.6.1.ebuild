# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="The Insteon frontend for Home Assistant"
HOMEPAGE="https://github.com/pyinsteon/insteon-panel https://pypi.org/project/insteon-frontend-home-assistant/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
DOCS="README.md"
