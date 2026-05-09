# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Library to decode and encode radio frequency signals."
HOMEPAGE="https://github.com/home-assistant-libs/rf-protocols https://pypi.org/project/rf-protocols"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
