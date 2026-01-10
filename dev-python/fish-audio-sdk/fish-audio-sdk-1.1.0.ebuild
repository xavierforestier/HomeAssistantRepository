# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="The official Python library for the Fish Audio API"
HOMEPAGE="https://github.com/fishaudio/fish-audio-python https://pypi.org/project/fish-audio-sdk/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/httpx-0.27.2[${PYTHON_USEDEP}]
	>=dev-python/ormsgpack-1.5.0[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.9.1[${PYTHON_USEDEP}]
	>=dev-python/httpx-ws-0.6.2[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
