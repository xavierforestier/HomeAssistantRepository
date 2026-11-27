# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Library implementing ZHA for Home Assistant"
HOMEPAGE="https://github.com/zigpy/zha/ https://pypi.org/project/zha/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

DOCS="README.md"

RDEPEND="
	dev-python/attrs[${PYTHON_USEDEP}]
	dev-python/frozendict[${PYTHON_USEDEP}]
	~dev-python/zigpy-2.4.1[${PYTHON_USEDEP}]
	~dev-python/bellows-1.2.1[${PYTHON_USEDEP}]
	~dev-python/zigpy-znp-1.1.1[${PYTHON_USEDEP}]
	~dev-python/zigpy-deconz-1.1.1[${PYTHON_USEDEP}]
	~dev-python/zigpy-xbee-0.22.0[${PYTHON_USEDEP}]
	~dev-python/zigpy-zigate-0.14.0[${PYTHON_USEDEP}]
	~dev-python/zigpy-ziggurat-1.2.0[${PYTHON_USEDEP}]
	>=dev-python/zha-quirks-2.4.0[${PYTHON_USEDEP}]
"

src_prepare() {
	# setuptools-git-versioning is not packaged: without it the version is 0.0.0
	sed -e "s/^dynamic = \[\"version\"\]\$/version = \"${PV}\"/" \
		-e 's/, "setuptools-git-versioning[^"]*"//' -i pyproject.toml || die
	grep -qx "version = \"${PV}\"" pyproject.toml || die "failed to set the version in pyproject.toml"
	distutils-r1_src_prepare
}

distutils_enable_tests pytest
