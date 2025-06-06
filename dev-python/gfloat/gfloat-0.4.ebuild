# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Generic floating-point types in Python"
HOMEPAGE="
	https://github.com/graphcore-research/gfloat/
	https://pypi.org/project/gfloat/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm ~arm64 ~x86"
IUSE="test-rust"

RDEPEND="
	dev-python/more-itertools[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/ml-dtypes[${PYTHON_USEDEP}]
		dev-python/tabulate[${PYTHON_USEDEP}]
		test-rust? (
			dev-python/nbval[${PYTHON_USEDEP}]
		)
	)
"

distutils_enable_tests pytest

python_test() {
	local EPYTEST_IGNORE=(
		# require jax
		docs/source/03-value-tables.ipynb
		docs/source/04-benchmark.ipynb
		test/test_jax.py
		# requires mx (possibly git version), torch
		test/test_microxcaling.py
	)

	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	if has_version "dev-python/nbval[${PYTHON_USEDEP}]"; then
		epytest -p nbval
	else
		epytest -o addopts=
	fi
}
