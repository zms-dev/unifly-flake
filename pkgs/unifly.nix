{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  openssl,
  dbus,
  cacert,
  stdenv,
}:

rustPlatform.buildRustPackage rec {
  pname = "unifly";
  version = "0.9.1";

  src = fetchFromGitHub {
    owner = "hyperb1iss";
    repo = "unifly";
    rev = "v${version}";
    hash = "sha256-u+nERyym51tPD13QGNO0XeqPse+qydWT9wudpwfJuso=";
  };

  cargoHash = "sha256-71kQ6Rv79ehW2h4cmD0L3DGOC3sfv4Qw1KK0KNN/c/g=";

  postPatch = ''
    rm -f .cargo/config.toml
  '';

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    openssl
    dbus
  ];

  preCheck = ''
    export SSL_CERT_FILE=${cacert}/etc/ssl/certs/ca-bundle.crt
  '';

  meta = with lib; {
    description = "Elegant UniFi network management CLI & TUI";
    homepage = "https://github.com/hyperb1iss/unifly";
    license = licenses.asl20;
    maintainers = [ ];
    mainProgram = "unifly";
  };
}
