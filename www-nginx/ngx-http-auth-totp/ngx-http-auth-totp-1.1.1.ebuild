# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit nginx-module
MY_PN="nginx-http-auth-totp"
DESCRIPTION="Time-based one-time password (TOTP) authentication for Nginx"
HOMEPAGE="https://github.com/xavierforestier/nginx-http-auth-totp"
SRC_URI="https://github.com/xavierforestier/nginx-http-auth-totp/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
