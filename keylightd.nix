{
  src,
  pkgs,
  craneLib,
  ...
}: let
  inherit (craneLib.crateNameFromCargoToml {cargoToml = "${src}/Cargo.toml";}) pname version;

  cargoArtifacts = craneLib.buildDepsOnly {
    inherit pname version src;
  };
in
  craneLib.buildPackage
  {
    inherit pname version src cargoArtifacts;
  }
