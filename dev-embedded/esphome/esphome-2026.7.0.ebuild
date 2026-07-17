# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
DISTUTILS_SINGLE_IMPL=1
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Make creating custom firmwares for ESP32/ESP8266 super easy."
HOMEPAGE="https://github.com/esphome/esphome https://pypi.org/project/esphome/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="+server test"
RESTRICT="!test? ( test )"

DOCS="README.md"

RDEPEND="
	$( python_gen_cond_dep '
    server? (
		dev-embedded/esphome-device-builder[${PYTHON_USEDEP}]
	)
	>=dev-python/cryptography-48.0.1[${PYTHON_USEDEP}]
	~dev-python/voluptuous-0.16.0[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-6.0.3[${PYTHON_USEDEP}]
	>=dev-python/paho-mqtt-1.6.1[${PYTHON_USEDEP}]
	~dev-python/colorama-0.4.6[${PYTHON_USEDEP}]
	>=dev-python/tzlocal-5.4.4[${PYTHON_USEDEP}]
	>=dev-python/tzdata-2026.2[${PYTHON_USEDEP}]
	~dev-python/pyserial-3.5[${PYTHON_USEDEP}]
	~dev-embedded/platformio-6.1.19[${PYTHON_SINGLE_USEDEP}]
	~dev-embedded/esptool-5.3.1[${PYTHON_SINGLE_USEDEP}]
	>=dev-python/click-8.3.3[${PYTHON_USEDEP}]
	>=dev-python/aioesphomeapi-45.6.0[${PYTHON_USEDEP}]
	>=dev-python/zeroconf-0.150.0[${PYTHON_USEDEP}]
	~dev-python/puremagic-2.2.0[${PYTHON_USEDEP}]
	~dev-python/ruamel-yaml-0.19.1[${PYTHON_USEDEP}]
	~dev-python/ruamel-yaml-clib-0.2.15[${PYTHON_USEDEP}]
	~dev-python/esphome-glyphsets-0.2.0[${PYTHON_USEDEP}]
	>=dev-python/pillow-12.0.0[${PYTHON_USEDEP}]
	~dev-python/resvg-py-0.3.3[${PYTHON_USEDEP}]
	~dev-python/freetype-py-2.5.1[${PYTHON_USEDEP}]
	~dev-python/jinja2-3.1.6[${PYTHON_USEDEP}]
	>=dev-python/bleak-2.1.1[${PYTHON_USEDEP}]
	>=dev-python/smpclient-7.2.0[${PYTHON_USEDEP}]
	~dev-python/requests-2.34.2[${PYTHON_USEDEP}]
	>=dev-python/py7zr-1.1.3[${PYTHON_USEDEP}]
	>=dev-python/platformdirs-4.10.0[${PYTHON_USEDEP}]
	>=dev-python/pyparsing-3.3.2[${PYTHON_USEDEP}]
	>=dev-python/argcomplete-3.7.0[${PYTHON_USEDEP}]
	' )
"

BDEPEND="
	$( python_gen_cond_dep '
	test? (
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/asyncmock[${PYTHON_USEDEP}]
		dev-python/hypothesis[${PYTHON_USEDEP}]
	)
	' )
"

distutils_enable_tests pytest
