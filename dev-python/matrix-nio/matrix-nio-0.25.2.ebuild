# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="A Python Matrix client library, designed according to sans I/O principles."
HOMEPAGE="https://github.com/poljar/matrix-nio https://pypi.org/project/matrix-nio/"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="e2e test"
RESTRICT="!test? ( test )"

DOCS="README.md"

RDEPEND="
	>=dev-python/aiohttp-3.10.0[${PYTHON_USEDEP}]
	>=dev-python/aiofiles-24.1.0[${PYTHON_USEDEP}]
	>=dev-python/h11-0.14.0[${PYTHON_USEDEP}]
	>=dev-python/h2-4.0.0[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-4.14.0[${PYTHON_USEDEP}]
	>=dev-python/unpaddedbase64-2.1.0[${PYTHON_USEDEP}]
	>=dev-python/pycryptodome-3.10.1[${PYTHON_USEDEP}]
	>=dev-python/peewee-3.14.4[${PYTHON_USEDEP}]
	>=dev-python/cachetools-5.3[${PYTHON_USEDEP}]
	>=dev-python/aiohttp-socks-0.8.0[${PYTHON_USEDEP}]
	e2e? (
		>=dev-python/atomicwrites-1.4.0[${PYTHON_USEDEP}]
		>=dev-python/cachetools-4.2.1[${PYTHON_USEDEP}]
		>=dev-python/peewee-3.14.4[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
