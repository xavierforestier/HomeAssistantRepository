# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Find the vendor for a given MAC address"
HOMEPAGE="https://github.com/bauerj/mac_vendor_lookup https://pypi.org/project/mac-vendor-lookup"
SRC_URI="https://github.com/bauerj/mac_vendor_lookup/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	dev-python/aiohttp[${PYTHON_USEDEP}]
	dev-python/aiofiles[${PYTHON_USEDEP}]
"

src_prepare() {
	xzcat "${FILESDIR}/mac-vendors.txt.xz" > "${S}/mac-vendors.txt" || die
	eapply_user
}

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
