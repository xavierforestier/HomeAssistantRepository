# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="A modern, type-safe, async Python library for controlling LIFX lights"
HOMEPAGE="https://github.com/Djelibeybi/lifx-async https://pypi.org/project/lifx-async"

LICENSE="UPL 1.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
