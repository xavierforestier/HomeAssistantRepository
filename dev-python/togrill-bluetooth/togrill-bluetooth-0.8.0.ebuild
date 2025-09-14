# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14})

inherit distutils-r1 pypi

DESCRIPTION="Module to handle communication with ToGrill compatible temperature probes."

HOMEPAGE="https://github.com/elupus/togrill-bluetooth https://pypi.org/project/togrill-bluetooth/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="cli"

RDEPEND="
	>=dev-python/bleak-1.0.1[${PYTHON_USEDEP}]
	>=dev-python/bleak-retry-connector-4.0.0[${PYTHON_USEDEP}]
	cli? (
		>=dev-python/anyio-4.9.0[${PYTHON_USEDEP}]
		>=dev-python/asyncclick-8.1.8[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
