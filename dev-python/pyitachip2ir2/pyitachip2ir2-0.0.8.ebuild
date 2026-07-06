# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
PYPI_PN="pyitachip2ir2"
inherit distutils-r1 pypi

DESCRIPTION="A library for sending IR commands to an ITach IP2IR gateway"
HOMEPAGE="https://github.com/alanfischer/itachip2ir https://pypi.org/project/pyitachip2ir2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
RDEPEND="!dev-python/pyitachip2ir"
EPYTEST_PLUGINS=()
distutils_enable_tests pytest
