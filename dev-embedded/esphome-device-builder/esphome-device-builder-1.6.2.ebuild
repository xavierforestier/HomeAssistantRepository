# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
inherit readme.gentoo-r1 pypi distutils-r1

DESCRIPTION="ESPHome Device Builder Dashboard"
HOMEPAGE="https://github.com/esphome/device-builder https://esphome.io https://pypi.org/project/esphome-device-builder"

LICENSE="Apache2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

DEPEND="
	acct-group/esphome
	acct-user/esphome
	=dev-python/esphome-device-builder-frontend-0.1.255[${PYTHON_USEDEP}]
	>=dev-python/aiohttp-3.9.0[${PYTHON_USEDEP}]
	>=dev-python/aiohttp-asyncmdnsresolver-0.1.1[${PYTHON_USEDEP}]
	>=dev-python/colorlog-6.8.0[${PYTHON_USEDEP}]
	>=dev-python/cryptography-42.0.2[${PYTHON_USEDEP}]
	>=dev-python/fnv-hash-fast-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/ifaddr-0.2.0[${PYTHON_USEDEP}]
	>=dev-python/icmplib-3.0.4[${PYTHON_USEDEP}]
	>=dev-python/mashumaro-3.13[${PYTHON_USEDEP}]
	>=dev-python/orjson-3.9.0[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-6.0[${PYTHON_USEDEP}]
	>=dev-python/ruamel-yaml-0.18.0[${PYTHON_USEDEP}]
	>=dev-python/voluptuous-0.13.1[${PYTHON_USEDEP}]
	>=dev-python/zeroconf-0.150.0[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"

DISABLE_AUTOFORMATTING=1
DOC_CONTENTS="
The ESPHome device builder listens on port 6052
ESPHome configuration is in: /etc/${PN}
dashboard command line arguments are configured in: /etc/conf.d/${PN}
logging is to: /var/log/${PN}/{dashboard,warnings}.log
"

python_install_all() {
	dodoc "${DOCS}"
	distutils-r1_python_install_all
	keepdir "/etc/esphome"
	fowners -R "esphome:esphome" "/etc/esphome"
	keepdir "/var/log/esphome"
	fowners -R "esphome:esphome" "/var/log/esphome"
	newconfd "${FILESDIR}/esphome.conf.d" "esphome"
	newinitd "${FILESDIR}/esphome.init.d" "esphome"
	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
}

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

