# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	addr2line@0.21.0
	adler@1.0.2
	ahash@0.8.7
	aho-corasick@1.1.1
	allocator-api2@0.2.16
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	anstream@0.6.11
	anstyle-parse@0.2.2
	anstyle-query@1.0.0
	anstyle-wincon@3.0.1
	anstyle@1.0.4
	anyhow@1.0.75
	arboard@3.2.1
	async-broadcast@0.7.0
	async-channel@1.9.0
	async-channel@2.2.1
	async-io@2.3.2
	async-lock@2.8.0
	async-lock@3.3.0
	async-process@2.2.2
	async-recursion@1.0.5
	async-signal@0.2.6
	async-task@4.7.0
	async-trait@0.1.80
	atomic-waker@1.1.2
	autocfg@1.1.0
	backtrace@0.3.69
	base64@0.13.1
	better-panic@0.3.0
	bitflags@1.3.2
	bitflags@2.4.0
	block-buffer@0.10.4
	block@0.1.6
	blocking@1.4.0
	bumpalo@3.14.0
	byteorder@1.4.3
	bytes@1.5.0
	cassowary@0.3.0
	castaway@0.2.2
	cc@1.0.83
	cfg-if@1.0.0
	cfg_aliases@0.1.1
	chrono@0.4.31
	clap@4.4.6
	clap_builder@4.4.6
	clap_complete@4.4.3
	clap_derive@4.4.2
	clap_lex@0.5.1
	clipboard-anywhere@0.2.2
	clipboard-win@4.5.0
	colorchoice@1.0.0
	colored@2.0.4
	compact_str@0.7.1
	concurrent-queue@2.5.0
	console@0.15.7
	core-foundation-sys@0.8.4
	cpufeatures@0.2.9
	crossbeam-utils@0.8.16
	crossterm@0.27.0
	crossterm_winapi@0.9.1
	crypto-common@0.1.6
	derivative@2.2.0
	digest@0.10.7
	directories@5.0.1
	dirs-sys@0.4.1
	duct@0.13.6
	either@1.9.0
	encode_unicode@0.3.6
	endi@1.1.0
	enumflags2@0.7.9
	enumflags2_derive@0.7.9
	env_filter@0.1.0
	env_logger@0.11.1
	equivalent@1.0.1
	errno@0.3.8
	error-code@2.3.1
	event-listener-strategy@0.4.0
	event-listener-strategy@0.5.1
	event-listener@2.5.3
	event-listener@4.0.3
	event-listener@5.3.0
	fastrand@2.0.1
	futures-channel@0.3.30
	futures-core@0.3.30
	futures-executor@0.3.28
	futures-io@0.3.30
	futures-lite@1.13.0
	futures-lite@2.0.0
	futures-macro@0.3.30
	futures-sink@0.3.30
	futures-task@0.3.30
	futures-util@0.3.30
	futures@0.3.28
	fxhash@0.2.1
	generic-array@0.14.7
	gethostname@0.2.3
	getrandom@0.2.10
	gimli@0.28.0
	hashbrown@0.14.1
	heck@0.4.1
	hermit-abi@0.3.9
	hex@0.4.3
	humantime@2.1.0
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.57
	indexmap@2.0.2
	indoc@2.0.4
	is-docker@0.2.0
	is-terminal@0.4.9
	is-wsl@0.4.0
	itertools@0.12.0
	itoa@1.0.11
	js-sys@0.3.64
	lazy_static@1.4.0
	libc@0.2.153
	linux-raw-sys@0.4.13
	lock_api@0.4.10
	log@0.4.20
	lru@0.12.1
	malloc_buf@0.0.6
	matchers@0.1.0
	memchr@2.6.3
	memoffset@0.6.5
	memoffset@0.9.1
	miniz_oxide@0.7.1
	mio@0.8.8
	nix@0.24.3
	nix@0.28.0
	nu-ansi-term@0.46.0
	num-traits@0.2.16
	num_cpus@1.16.0
	objc-foundation@0.1.1
	objc@0.2.7
	objc_id@0.1.1
	object@0.32.1
	once_cell@1.18.0
	option-ext@0.2.0
	ordered-stream@0.2.0
	os_pipe@1.1.4
	overload@0.1.1
	parking@2.1.1
	parking_lot@0.12.1
	parking_lot_core@0.9.8
	paste@1.0.14
	pin-project-lite@0.2.13
	pin-utils@0.1.0
	piper@0.2.1
	polling@3.7.0
	ppv-lite86@0.2.17
	proc-macro-crate@3.1.0
	proc-macro2@1.0.81
	quote@1.0.36
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	ratatui@0.26.2
	redox_syscall@0.2.16
	redox_syscall@0.3.5
	redox_users@0.4.3
	regex-automata@0.1.10
	regex-automata@0.4.6
	regex-syntax@0.6.29
	regex-syntax@0.8.3
	regex@1.10.4
	rustc-demangle@0.1.23
	rustix@0.38.34
	rustversion@1.0.14
	ryu@1.0.17
	scopeguard@1.2.0
	serde@1.0.188
	serde_derive@1.0.188
	serde_repr@0.1.19
	sha1@0.10.6
	sharded-slab@0.1.6
	shared_child@1.0.0
	signal-hook-mio@0.2.3
	signal-hook-registry@1.4.1
	signal-hook@0.3.17
	slab@0.4.9
	smallvec@1.11.1
	socket2@0.5.4
	stability@0.2.0
	static_assertions@1.1.0
	str-buf@1.0.6
	strsim@0.10.0
	strum@0.26.2
	strum_macros@0.26.2
	syn@1.0.109
	syn@2.0.60
	tempfile@3.8.0
	terminal_size@0.3.0
	thiserror-impl@1.0.49
	thiserror@1.0.49
	thread_local@1.1.7
	tokio-macros@2.1.0
	tokio-stream@0.1.14
	tokio-util@0.7.9
	tokio@1.32.0
	toml_datetime@0.6.5
	toml_edit@0.21.1
	tracing-attributes@0.1.27
	tracing-core@0.1.32
	tracing-log@0.1.3
	tracing-macros@0.0.0
	tracing-subscriber@0.3.17
	tracing@0.1.40
	tui-input@0.8.0
	tui-logger@0.11.1
	typenum@1.17.0
	uds_windows@1.1.0
	unicase@2.7.0
	unicode-ident@1.0.12
	unicode-segmentation@1.10.1
	unicode-width@0.1.11
	utf8parse@0.2.1
	valuable@0.1.0
	version_check@0.9.4
	waker-fn@1.1.1
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.87
	wasm-bindgen-macro-support@0.2.87
	wasm-bindgen-macro@0.2.87
	wasm-bindgen-shared@0.2.87
	wasm-bindgen@0.2.87
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-wsapoll@0.1.1
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-sys@0.45.0
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-targets@0.42.2
	windows-targets@0.48.5
	windows-targets@0.52.5
	windows@0.48.0
	windows_aarch64_gnullvm@0.42.2
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.5
	windows_aarch64_msvc@0.42.2
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.5
	windows_i686_gnu@0.42.2
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.5
	windows_i686_gnullvm@0.52.5
	windows_i686_msvc@0.42.2
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.5
	windows_x86_64_gnu@0.42.2
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.5
	windows_x86_64_gnullvm@0.42.2
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.5
	windows_x86_64_msvc@0.42.2
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.5
	winnow@0.5.15
	x11rb-protocol@0.10.0
	x11rb@0.10.1
	xdg-home@1.1.0
	zbus@4.1.2
	zbus_macros@4.1.2
	zbus_names@3.0.0
	zerocopy-derive@0.7.32
	zerocopy@0.7.32
	zvariant@4.0.2
	zvariant_derive@4.0.2
	zvariant_utils@1.1.0
"

inherit cargo

DESCRIPTION="A simple TUI for interacting with systemd services and their logs"
HOMEPAGE="https://github.com/rgwood/systemctl-tui/"
SRC_URI="
	https://github.com/rgwood/systemctl-tui/archive/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+=" Apache-2.0 Boost-1.0 MIT MPL-2.0 Unicode-DFS-2016"
SLOT="0"
KEYWORDS="~amd64"

QA_PREBUILT="*"
