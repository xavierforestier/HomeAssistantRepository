# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Use the Remember the Milk API with aiohttp."
HOMEPAGE="https://github.com/MartinHjelmare/aiortm https://pypi.org/project/aiortm"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/aiohttp-3.8[${PYTHON_USEDEP}]
	>=dev-python/ciso8601-2.3[${PYTHON_USEDEP}]
	>=dev-python/mashumaro-3.10[${PYTHON_USEDEP}]
	>=dev-python/yarl-1.7[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
