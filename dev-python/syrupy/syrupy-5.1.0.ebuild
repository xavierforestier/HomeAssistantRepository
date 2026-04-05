# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Pytest Snapshot Test Utility"
HOMEPAGE="https://github.com/syrupy-project/syrupy https://pypi.org/project/syrupy"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 w86"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
