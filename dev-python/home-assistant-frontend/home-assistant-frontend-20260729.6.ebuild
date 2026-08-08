# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_14 )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

SRC_URI="
	https://github.com/home-assistant/frontend/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz
	https://github.com/xavierforestier/home-assistant-frontend/raw/refs/heads/main/${P}-node_modules.tar.xz -> ${P}-node_modules.gh.tar.xz
	https://github.com/xavierforestier/home-assistant-frontend/raw/refs/heads/main/${P}-translations.tar.xz -> ${P}-translations.gh.tar.xz
"

S="${WORKDIR}/frontend-${PV}"

DESCRIPTION="The Home Assistant frontend"
HOMEPAGE="https://github.com/home-assistant/frontend https://pypi.org/project/home-assistant-frontend/"
PATCHES=(
	"${FILESDIR}/${PN}-disable-age-check.patch"
	"${FILESDIR}/${PN}-cover-positions.patch"
	"${FILESDIR}/${PN}-faster-compress.patch"
)

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"
DOCS="README.md"
RDEPEND="
	sys-apps/yarn
	net-libs/nodejs[npm]
	=dev-python/user-agents-2.0-r2[${PYTHON_USEDEP}]
"

python_compile() {
	yarn build
	distutils-r1_python_compile
}

python_test() {
	yarn test
	distutils-r1_python_test
}
