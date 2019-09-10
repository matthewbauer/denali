{ gcc6Stdenv, lib, fetchurl, perl, python2, ruby, bison, gperf, cmake, ninja
, pkgconfig, gettext, gobject-introspection, libnotify, gnutls, libgcrypt
, gtk3, wayland, libwebp, epoxy, at-spi2-core, libxml2, libsoup, libsecret
, libxslt, harfbuzz, libpthreadstubs, pcre, nettle, libtasn1, p11-kit, sqlite
, libidn, libedit, readline, libGLU_combined, libintl, openjpeg
, glib-networking, woff2, gst_all_1
}:

gcc6Stdenv.mkDerivation rec {
  pname = "webkitgtk";
  version = "2.24.4";

  src = fetchurl {
    url = "https://webkitgtk.org/releases/${pname}-${version}.tar.xz";
    sha256 = "1n3x5g1z6rg9n1ssna7wi0z6zlprjm4wzk544v14wqi6q0lv2s46";
  };

  postPatch = ''
    patchShebangs .
  '';

  cmakeFlags = [
    "-DPORT=GTK"
    "-DENABLE_INTROSPECTION=ON"
    "-DENABLE_GLES2=ON"
    "-DENABLE_GEOLOCATION=OFF"
    "-DENABLE_PLUGIN_PROCESS_GTK2=OFF"
    "-DENABLE_SPELLCHECK=OFF"
    "-DENABLE_X11_TARGET=OFF"
    "-DUSE_LIBNOTIFY=OFF"
    "-DUSE_LIBHYPHEN=OFF"
  ];

  nativeBuildInputs = [
    cmake ninja perl python2 ruby bison gperf
    pkgconfig gettext gobject-introspection
  ];

  buildInputs = [
    libintl libwebp gnutls pcre nettle libidn libgcrypt woff2
    libxml2 libsecret libxslt libpthreadstubs libtasn1 p11-kit
    openjpeg gst_all_1.gst-plugins-base gst_all_1.gst-plugins-bad
    epoxy at-spi2-core
    glib-networking wayland sqlite (harfbuzz.override { withIcu = true; })
  ];

  propagatedBuildInputs = [
    libsoup gtk3
  ];

  outputs = [ "out" "dev" ];
}
