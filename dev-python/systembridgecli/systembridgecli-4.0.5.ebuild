# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="This is a CLI interface package for the System Bridge project"
HOMEPAGE="https://github.com/timmo001/system-bridge-cli https://pypi.org/project/systembridgecli/"
PATCHES="${FILESDIR}/requirements.patch"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/incremental-22.10.0[${PYTHON_USEDEP}]
	>=dev-python/shellingham-1.5.4[${PYTHON_USEDEP}]
	>=dev-python/systembridgeconnector-4.0.5[${PYTHON_USEDEP}]
	>=dev-python/systembridgeshared-4.0.4[${PYTHON_USEDEP}]
	>=dev-python/typer-0.12.3[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
