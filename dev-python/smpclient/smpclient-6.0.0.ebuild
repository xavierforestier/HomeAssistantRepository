# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Simple Management Protocol (SMP) Client for remotely managing MCU firmware"
HOMEPAGE="https://github.com/intercreate/smpclient https://pypi.org/project/smpclient/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

PATCHES="${FILESDIR}/${PN}-fix-poetry.patch"

RDEPEND="
	>=dev-python/smp-4.0.2[${PYTHON_USEDEP}]
	>=dev-python/intelhex-2.3.0[${PYTHON_USEDEP}]
	>=dev-python/bleak-2.0.0[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
