# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Library implementing ZHA for Home Assistant"
HOMEPAGE="https://github.com/zigpy/zha/ https://pypi.org/project/zha/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

DOCS="README.md"

RDEPEND="
	~dev-python/zigpy-0.80.1[${PYTHON_USEDEP}]
	~dev-python/bellows-0.45.1[${PYTHON_USEDEP}]
	~dev-python/zigpy-znp-0.14.1[${PYTHON_USEDEP}]
	~dev-python/zigpy-deconz-0.25.0[${PYTHON_USEDEP}]
	~dev-python/zigpy-xbee-0.21.0[${PYTHON_USEDEP}]
	~dev-python/zigpy-zigate-0.13.3[${PYTHON_USEDEP}]
	~dev-python/zha-quirks-0.0.139[${PYTHON_USEDEP}]
	~dev-python/pyserial-3.5[${PYTHON_USEDEP}]
	dev-python/pyserial-asyncio-fast[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
