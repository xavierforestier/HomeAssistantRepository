# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Universally unique lexicographically sortable identifier"
HOMEPAGE="https://github.com/mdomke/python-ulid https://pypi.org/project/python-ulid/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

BDEPEND="
	dev-python/gpep517[${PYTHON_USEDEP}]
	dev-python/installer[${PYTHON_USEDEP}]
	dev-python/hatchling[${PYTHON_USEDEP}]
	dev-python/hatch-fancy-pypi-readme[${PYTHON_USEDEP}]
	dev-python/hatch-vcs[${PYTHON_USEDEP}]
"
EPYTEST_PLUGINS=()
distutils_enable_tests pytest
