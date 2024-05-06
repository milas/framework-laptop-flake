{
  src,
  cmake,
  libftdi1,
  libusb1,
  pkg-config,
  stdenv,
}:
stdenv.mkDerivation {
  inherit src;
  name = "fw-ectool";
  version = "main-${src.rev}";
  mainProgram = "ectool";

  buildInputs = [libusb1 libftdi1];
  nativeBuildInputs = [cmake pkg-config];

  postPatch = ''
    echo 'install(TARGETS ectool DESTINATION ''${CMAKE_INSTALL_PREFIX}/bin)' >> ./src/CMakeLists.txt
  '';

  #    installPhase = ''
  #      install -Dm755 ./build/src/ectool $out/bin/fw-ectool

  #    '';
}
