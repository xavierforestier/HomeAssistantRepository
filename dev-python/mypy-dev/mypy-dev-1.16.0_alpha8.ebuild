# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
MY_PV=${PV/_alpha/a}
inherit distutils-r1 pypi multiprocessing

DESCRIPTION="Optional static typing for Python"
HOMEPAGE="
	https://www.mypy-lang.org/
	https://github.com/python/mypy/
	https://github.com/cdce8p/mypy-dev https://pypi.org/project/mypy-dev/
"
SRC_URI="$(pypi_sdist_url "${PN}" "${MY_PV}")"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="+native-extensions test"
RESTRICT="!test? ( test )"
DOCS="README.md"

# stubgen collides with this package: https://bugs.gentoo.org/585594
RDEPEND="
	!dev-python/mypy[${PYTHON_USEDEP}]
	>=dev-python/psutil-4[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.6.0[${PYTHON_USEDEP}]
	>=dev-python/mypy-extensions-1.0.0[${PYTHON_USEDEP}]
"
BDEPEND="
	native-extensions? (
		${RDEPEND}
		dev-python/types-psutil[${PYTHON_USEDEP}]
		dev-python/types-setuptools[${PYTHON_USEDEP}]
	)
	test? (
		>=dev-python/attrs-18.0[${PYTHON_USEDEP}]
		>=dev-python/filelock-3.3.0[${PYTHON_USEDEP}]
		>=dev-python/lxml-4.9.1[${PYTHON_USEDEP}]
	)
"

EPYTEST_XDIST=1
distutils_enable_tests pytest

# frustratingly, mypyc produces non-deterministic output. If ccache is enabled it will be a waste of time,
# but simultaneously it might trash your system and fill up the cache with a giant wave of non-reproducible
# test files (https://github.com/mypyc/mypyc/issues/1014)
export CCACHE_DISABLE=1

src_compile() {
	local -x MYPY_USE_MYPYC
	MYPY_USE_MYPYC="$(usex native-extensions 1 0)"
	distutils-r1_src_compile
}

python_test() {
	local EPYTEST_DESELECT=(
		# the majority of them require Internet (via pip)
		mypy/test/testpep561.py
		# known broken with assertions enabled
		# https://github.com/python/mypy/issues/16043
		mypyc/test/test_run.py::TestRun::run-i64.test::testI64GlueMethodsAndInheritance
		mypyc/test/test_run.py::TestRun::run-floats.test::testFloatOps
		# these assume that types-docutils are not installed
		mypy/test/testpythoneval.py::PythonEvaluationSuite::pythoneval.test::testIgnoreImportIfNoPython3StubAvailable
		mypy/test/testpythoneval.py::PythonEvaluationSuite::pythoneval.test::testNoPython3StubAvailable
		# TODO
		mypy/test/meta/test_parse_data.py
		mypy/test/meta/test_update_data.py
		mypy/test/teststubtest.py::StubtestUnit::test_runtime_typing_objects
	)
	case ${EPYTHON} in
		python3.12)
			EPYTEST_DESELECT+=(
				# more assertions, sigh
				mypyc/test/test_run.py::TestRun::run-bools.test::testBoolOps
				mypyc/test/test_run.py::TestRun::run-i64.test::testI64BasicOps
				mypyc/test/test_run.py::TestRun::run-i64.test::testI64DefaultArgValues
				mypyc/test/test_run.py::TestRun::run-i64.test::testI64ErrorValuesAndUndefined
			)
			;;
	esac

	# Some mypy/test/testcmdline.py::PythonCmdlineSuite tests
	# fail with high COLUMNS values
	local -x COLUMNS=80

	# The tests depend on having in-source compiled extensions if you want to
	# test those compiled extensions. Various crucial test dependencies aren't
	# installed. Even pyproject.toml is needed because that's where pytest args
	# are in. Hack them into the build directory and delete them afterwards.
	# See: https://github.com/python/mypy/issues/16143
	local -x MYPY_TEST_PREFIX="${S}"
	cd "${BUILD_DIR}/install$(python_get_sitedir)" || die
	cp -r "${S}"/{conftest.py,pyproject.toml} . || die

	local failed=
	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	nonfatal epytest -n "$(makeopts_jobs)" --dist=worksteal || failed=1

	rm conftest.py pyproject.toml || die

	[[ ${failed} ]] && die "epytest failed with ${EPYTHON}"
}
