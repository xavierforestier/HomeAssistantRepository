# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="An implementation of the ACME protocol"
HOMEPAGE="
	https://github.com/certbot/certbot
	https://pypi.org/project/acme/
	https://letsencrypt.org/
"

LICENSE="metapackage"
SLOT="0"

KEYWORDS="amd64 ~arm arm64 ~ppc64 ~riscv x86"

RDEPEND="
	~app-crypt/certbot-${PV}
"

pkg_postinst() {
	elog "This is a meta-package to help in transition to single package "
	elog "app-crypt/certbot."
	elog "It is advice to simply deselect this package and to emerge "
	elog "app-crypt/certbot where module ${PN} is present by default."
}
