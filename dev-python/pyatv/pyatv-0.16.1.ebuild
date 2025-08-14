# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi
DESCRIPTION="A client library for Apple TV and AirPlay devices"
HOMEPAGE="https://github.com/postlund/pyatv/ https://pyatv.dev https://pypi.org/project/pyatv/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

DOCS="README.md"

RDEPEND="
	>=dev-python/aiohttp-3.12.13[${PYTHON_USEDEP}]
	dev-python/async-timeout[${PYTHON_USEDEP}]
	>=dev-python/chacha20poly1305-reuseable-0.13.2[${PYTHON_USEDEP}]
	>=dev-python/cryptography-45[${PYTHON_USEDEP}]
	>=dev-python/ifaddr-0.2.0[${PYTHON_USEDEP}]
	>=dev-python/miniaudio-1.61[${PYTHON_USEDEP}]
	>=dev-python/protobuf-6.31.1[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.11.7[${PYTHON_USEDEP}]
	>=dev-python/requests-2.32.4[${PYTHON_USEDEP}]
	>=dev-python/srptools-1.0.1[${PYTHON_USEDEP}]
	>=dev-python/tabulate-0.9.0[${PYTHON_USEDEP}]
	>=dev-python/tinytag-2.1.1[${PYTHON_USEDEP}]
	>=dev-python/zeroconf-0.147.0[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-python/pytest-runner[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
	)"

distutils_enable_tests pytest
