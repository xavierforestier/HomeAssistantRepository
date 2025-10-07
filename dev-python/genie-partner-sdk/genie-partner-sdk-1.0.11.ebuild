# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )
inherit distutils-r1 pypi

DESCRIPTION="An SDK to interact with the AladdinConnect (or OHD) partner API"
HOMEPAGE="https://github.com/genie-garage/aladdin-python-sdk https://pypi.org/project/genie-partner-sdk/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
