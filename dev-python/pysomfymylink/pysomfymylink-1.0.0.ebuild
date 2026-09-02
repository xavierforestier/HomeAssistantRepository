# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Async Python client for the Somfy MyLink Synergy socket API (a maintained rewrite of somfy-mylink-synergy)"
HOMEPAGE="https://github.com/sslivins/pysomfymylink https://pypi.org/project/pysomfymylink"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
