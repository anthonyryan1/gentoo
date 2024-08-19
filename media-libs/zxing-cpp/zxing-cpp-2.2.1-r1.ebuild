# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )

DISTUTILS_EXT=1
DISTUTILS_OPTIONAL=1
DISTUTILS_USE_PEP517=setuptools

inherit cmake distutils-r1

DESCRIPTION="C++ Multi-format 1D/2D barcode image processing library"
HOMEPAGE="https://github.com/zxing-cpp/zxing-cpp"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0/3"
KEYWORDS="amd64 ~arm arm64 ~loong ppc64 ~riscv x86"
IUSE="python test"

DEPEND="python? ( dev-python/pybind11 )"
RDEPEND="${PYTHON_DEPS}"
BDEPEND="${DISTUTILS_DEPS}
	test? (
		dev-cpp/gtest
	)
"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="!test? ( test )"

src_prepare() {
	cmake_src_prepare

	if use python; then
		cd "${S}"/wrappers/python || die
		distutils-r1_src_prepare
	fi
}

src_configure() {
	# TODO: Next release deprecates -DBUILD_* and replaces it with -DZXING_*
	local mycmakeargs=(
		-DBUILD_DEPENDENCIES=LOCAL

		-DBUILD_EXAMPLES=OFF # nothing is installed

		# Most of the functionality is covered by blackbox tests
		# But we're blocked until we can get test/samples in tarball form
		# https://github.com/zxing-cpp/zxing-cpp/issues/748
		# https://github.com/zxing-cpp/zxing-cpp/issues/312#issuecomment-2299718373
		# Will also need BDEPEND on dev-libs/stb & dev-libs/libfmt
		-DBUILD_BLACKBOX_TESTS=OFF

		-DBUILD_UNIT_TESTS=$(usex test ON OFF)
	)
	cmake_src_configure

	local DISTUTILS_ARGS=(
		-DBUILD_DEPENDENCIES=LOCAL
		-DBUILD_SHARED_LIBS=ON
	)

	if use python; then
		cd "${S}"/wrappers/python || die
		distutils-r1_src_configure
	fi
}

src_compile() {
	cmake_src_compile

	if use python; then
		cd "${S}"/wrappers/python || die
		distutils-r1_src_compile
	fi
}

src_install() {
	cmake_src_install

	if use python; then
		cd "${S}"/wrappers/python || die
		distutils-r1_src_install
	fi

}

src_test() {
	cmake_src_test
}
