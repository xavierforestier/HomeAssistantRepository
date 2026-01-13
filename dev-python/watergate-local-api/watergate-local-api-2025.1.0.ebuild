# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Python package to interact with the Watergate Local API."
HOMEPAGE="https://github.com/watergate-ai/watergate-local-api-python https://pypi.org/project/watergate-local-api/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/aiohttp-3.13.1[${PYTHON_USEDEP}]
	>=dev-python/pytest-8.4.2[${PYTHON_USEDEP}]
	>=dev-python/pytest-asyncio-1.2.0[${PYTHON_USEDEP}]
	>=dev-python/aioresponses-0.7.8[${PYTHON_USEDEP}]
"
src_prepare() {
	echo "${PVR}" >version.txt
	eapply_user
}
src_install() {
	default
	rm -rf "${D}/tests"
}
distutils_enable_tests pytest
