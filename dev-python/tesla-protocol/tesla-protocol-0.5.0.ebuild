# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_14 )

inherit distutils-r1 pypi

DESCRIPTION="Tesla vehicle-command, fleet-telemetry and energy protobuf bindings for Python"
HOMEPAGE="https://github.com/Teslemetry/tesla-protocol https://pypi.org/project/tesla-protocol"

LICENSE="Apache2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
RDEPENDS="
	>=dev-python/protobuf-6.32.0[${PYTHON_USEDEP}]
	>=dev-python/googleapis-common-protos-1.60[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
