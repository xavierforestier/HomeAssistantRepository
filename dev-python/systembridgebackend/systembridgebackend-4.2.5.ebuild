# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="System Bridge Backend"
HOMEPAGE="https://github.com/timmo001/system-bridge-backend https://pypi.org/project/systembridgebackend/"
PATCHES="${FILESDIR}/requirement.patch"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/aiofiles-23.2.1[${PYTHON_USEDEP}]
	>=dev-python/aiohttp-3.9.0[${PYTHON_USEDEP}]
	>=dev-python/fastapi-0.110.2[${PYTHON_USEDEP}]
	>=dev-python/incremental-22.10.0[${PYTHON_USEDEP}]
	>=dev-python/keyboard-0.13.5[${PYTHON_USEDEP}]
	>=media-libs/mutagen-1.47.0[${PYTHON_USEDEP}]
	>=dev-python/packaging-24.0[${PYTHON_USEDEP}]
	>=dev-python/plyer-2.1.0[${PYTHON_USEDEP}]
	>=dev-python/psutil-5.9.8[${PYTHON_USEDEP}]
	>=dev-python/python-multipart-0.0.9[${PYTHON_USEDEP}]
	>=dev-python/screeninfo-0.8.1[${PYTHON_USEDEP}]
	>=dev-python/systembridgeconnector-4.1.2[${PYTHON_USEDEP}]
	>=dev-python/systembridgemodels-4.1.0[${PYTHON_USEDEP}]
	>=dev-python/systembridgeshared-4.0.4[${PYTHON_USEDEP}]
	>=dev-python/typer-0.12.3[${PYTHON_USEDEP}]
	>=dev-python/uvicorn-0.29.0[${PYTHON_USEDEP}]
	>=dev-python/zeroconf-0.132.2[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
