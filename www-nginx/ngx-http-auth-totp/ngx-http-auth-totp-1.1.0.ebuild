# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
MY_PN="nginx-http-auth-totp"
inherit nginx-module

DESCRIPTION="Time-based one-time password (TOTP) authentication for Nginx"
HOMEPAGE="https://github.com/61131/nginx-http-auth-totp"
SRC_URI="https://github.com/61131/nginx-http-auth-totp/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
