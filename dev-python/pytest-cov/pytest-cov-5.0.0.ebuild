# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..13} pypy3 )

inherit distutils-r1 multiprocessing pypi

DESCRIPTION="pytest plugin for coverage reporting"
HOMEPAGE="
	https://github.com/pytest-dev/pytest-cov
	https://pypi.org/project/pytest-cov/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~loong ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"

RDEPEND="
	>=dev-python/py-1.4.22[${PYTHON_USEDEP}]
	>=dev-python/pytest-3.6[${PYTHON_USEDEP}]
	>=dev-python/coverage-6.4.4-r1[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/virtualenv[${PYTHON_USEDEP}]
		dev-python/fields[${PYTHON_USEDEP}]
		>=dev-python/process-tests-2.0.2[${PYTHON_USEDEP}]
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
	)
"

distutils_enable_sphinx docs \
	dev-python/furo
distutils_enable_tests pytest

python_test() {
	# NB: disabling all plugins speeds tests up a lot
	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	local -x PYTEST_PLUGINS=pytest_cov.plugin,xdist.plugin,xdist.looponfail

	local src=$(
		"${EPYTHON}" -c "import coverage as m; print(*m.__path__)" || die
	)
	# TODO: why do we need to do that?!
	# https://github.com/pytest-dev/pytest-cov/issues/517
	ln -s "${src}" \
		"${BUILD_DIR}/install$(python_get_sitedir)/coverage" || die

	nonfatal epytest -n "$(makeopts_jobs)" --dist=worksteal
	local ret=${?}

	rm "${BUILD_DIR}/install$(python_get_sitedir)/coverage" || die

	[[ ${ret} -ne 0 ]] && die "epytest failed on ${EPYTHON}"
}
