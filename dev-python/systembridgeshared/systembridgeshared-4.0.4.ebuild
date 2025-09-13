# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="This is a shared package for the System Bridge project"
HOMEPAGE="https://github.com/timmo001/system-bridge-shared https://pypi.org/project/systembridgeshared/"
PATCHES="${FILESDIR}/requirements.patch"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/aiohttp-3.9.3[${PYTHON_USEDEP}]
	>=dev-python/colorlog-6.8.2[${PYTHON_USEDEP}]
	>=dev-python/cryptography-42.0.5[${PYTHON_USEDEP}]
	>=dev-python/incremental-22.10.0[${PYTHON_USEDEP}]
	>=dev-python/systembridgemodels-4.0.4[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
