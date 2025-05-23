# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit rebar3

DESCRIPTION="PKIX certificates management library for Erlang"
HOMEPAGE="https://github.com/processone/pkix"
SRC_URI="
	https://github.com/processone/${PN}/archive/${PV}.tar.gz
		-> ${P}.tar.gz
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~arm ~sparc ~x86"

DOCS=( README.md )
