{
  src,
  pkgs,
  craneLib,
  ...
}: let
  commonArgs = {
    inherit src;
    strictDeps = true;

    buildInputs = with pkgs; [hidapi systemd];

    nativeBuildInputs = with pkgs; [pkg-config clang];
  };

  cargoArtifacts = craneLib.buildDepsOnly (commonArgs
    // {
      pname = "framework-system";
      version = src.rev;
    });

  individualCrateArgs =
    commonArgs
    // {
      inherit cargoArtifacts;
    };
in {
  framework-tool = craneLib.buildPackage (individualCrateArgs
    // {
      pname = "framework_tool";
      cargoExtraArgs = "-p framework_tool";
      inherit
        (craneLib.crateNameFromCargoToml {
          inherit src;
          cargoToml = "${src}/framework_tool/Cargo.toml";
        })
        version
        ;
    });
}
