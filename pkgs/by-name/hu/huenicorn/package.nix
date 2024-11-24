{
  lib,
  stdenv,
  fetchFromGitLab,
  cmake,
  pkg-config,
  opencv,
  curl,
  crow,
  nlohmann_json,
  mbedtls,
  pipewire,
  glib,
  wayland,
  libsysprof-capture,
  pcre2,
  util-linux,
  libselinux,
  libsepol,
  xorg,
  glm
}:

stdenv.mkDerivation rec {
  pname = "huenicorn";
  version = "1.0.9";

  src = fetchFromGitLab {
    owner = "openjowelsofts";
    repo = "huenicorn";
    rev = "v${version}";
    sha256 = "sha256-+IcIvudvFRu9VEiF0DAZX2ZtaIgz4ZCMgBPsAphdfrw=";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  buildInputs = [
    opencv
    curl
    crow
    nlohmann_json
    mbedtls
    pipewire
    glib
    wayland
    libsysprof-capture
    pcre2
    util-linux
    libselinux
    libsepol
    xorg.libX11
    xorg.libXext
    xorg.libXrandr
    glm
  ];

  # TODO: systemd service?
  # TODO: fix webroot
  installPhase = ''
    mkdir -p $out/bin
    cp huenicorn $out/bin
    cp -r webroot $out/bin
  '';

  meta = {
    description = "A Linux Ambilight driver for Philips Hue™ devices.";
    homepage = "https://huenicorn.org";
    downloadPage = "https://huenicorn.org/download";
    changelog = "https://gitlab.com/openjowelsofts/huenicorn/-/releases/v${version}";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ florensie ];
  };
}
