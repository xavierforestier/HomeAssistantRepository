# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Hook and simulate keyboard events on Windows and Linux"
HOMEPAGE="https://github.com/boppreh/keyboard https://pypi.org/project/keyboard/"
SRC_URI="$(pypi_sdist_url "${PN^}" "${PV}" ".zip" )"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

BDEPEND="app-arch/unzip"
EPYTEST_PLUGINS=()
distutils_enable_tests pytest
