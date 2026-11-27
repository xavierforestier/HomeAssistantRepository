# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Flashes Silicon Labs radios running EmberZNet or CPC multi-pan firmware"
HOMEPAGE="https://github.com/NabuCasa/universal-silabs-flasher https://pypi.org/project/universal-silabs-flasher/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

DOCS="README.md"

RDEPEND="
	dev-python/aiohttp[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	>=dev-python/zigpy-1.3.0[${PYTHON_USEDEP}]
	dev-python/crc[${PYTHON_USEDEP}]
	>=dev-python/bellows-0.49.0[${PYTHON_USEDEP}]
	dev-python/gpiod[${PYTHON_USEDEP}]
	dev-python/coloredlogs[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/pytest-timeout[${PYTHON_USEDEP}]
	)"

src_prepare() {
	# setuptools-git-versioning is not packaged: without it the version is 0.0.0
	sed -e "s/^dynamic = \[\"version\"\]\$/version = \"${PV}\"/" \
		-e 's/, "setuptools-git-versioning[^"]*"//' -i pyproject.toml || die
	grep -qx "version = \"${PV}\"" pyproject.toml || die "failed to set the version in pyproject.toml"
	distutils-r1_src_prepare
}

distutils_enable_tests pytest
