# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Library to interface an Envertech EVT-800 device"
HOMEPAGE="https://github.com/daniel-bergmann-00/pyenvertech-evt800 https://pypi.org/project/pyenvertechevt800"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
