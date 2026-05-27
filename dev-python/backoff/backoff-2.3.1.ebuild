# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )
PYPI_PN=python-backoff
inherit distutils-r1 pypi

DESCRIPTION="Function decoration for backoff and retry"
HOMEPAGE="https://github.com/python-backoff/backoff https://pypi.org/project/python-backoff/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

DOCS=( README.rst )

BDEPEND="
	test? (
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/responses[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
