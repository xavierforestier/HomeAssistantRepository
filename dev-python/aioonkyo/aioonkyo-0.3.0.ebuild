# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="A library for controlling Onkyo AV receivers"
HOMEPAGE="https://github.com/arturpragacz/aioonkyo https://pypi.org/project/aioonkyo/"

LICENSE="GPL-3.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
