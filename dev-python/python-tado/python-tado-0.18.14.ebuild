# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="PyTado -- Pythonize your central heating"
HOMEPAGE="https://github.com/wmalgadey/PyTado https://pypi.org/project/python-tado/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"
DOCS="README.md"

RDEPEND="
	dev-python/requests[${PYTHON_USEDEP}]
"

src_prepare() {
	echo -e "requests" > requirements.txt
	eapply_user
}

distutils_enable_tests pytest
