# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="System Bridge Connector"
HOMEPAGE="https://github.com/timmo001/system-bridge https://pypi.org/project/systembridgeconnector/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND=">=dev-python/aiohttp-3.8.5[${PYTHON_USEDEP}]
	>=dev-python/incremental-24.7.2[${PYTHON_USEDEP}]"

src_prepare() {
	echo -e "aiohttp\nincremental>=24.7.2\n" > requirements.txt
	echo -e "incremental>=24.7.2" > requirements_setup.txt
	eapply_user
}

distutils_enable_tests pytest
