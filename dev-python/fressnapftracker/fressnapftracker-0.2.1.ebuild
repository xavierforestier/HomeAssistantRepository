# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Asynchronous Python client for the Fressnapf Tracker GPS API"
HOMEPAGE="https://github.com/eifinger/fressnapftracker https://pypi.org/project/fressnapftracker/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/httpx-0.28.0[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.10.0[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
