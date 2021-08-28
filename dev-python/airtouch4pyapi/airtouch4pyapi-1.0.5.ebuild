# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1 git-r3

DESCRIPTION="An api allowing control of AC state (temperature, on/off, mode) of an Airtouch 4 controller locally over TCP"
HOMEPAGE="https://github.com/LonePurpleWolf/airtouch4pyapi https://pypi.org/project/airtouch4pyapi/"
EGIT_COMMIT="34783888846783c058fe79cec16feda45504f701"
EGIT_REPO_URI="https://github.com/LonePurpleWolf/airtouch4pyapi.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

DOCS="README.md"

RDEPEND=""
BDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
	)"

python_test() {
	nosetests --verbose || die
	py.test -v -v || die
}
