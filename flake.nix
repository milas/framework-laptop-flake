{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

# we just need ectool which was split into own repo at DHowett/ectool
#    framework-ec = {
#      url = "github:DHowett/framework-ec";
#      flake = false;
#    };

    fw-ectool = {
    url = "gitlab:DHowett/ectool?host=gitlab.howett.net";
    flake = false;
    };

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    fw-ectool,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (localSystem: let
      pkgs = nixpkgs.legacyPackages.${localSystem};
    in {
      apps.fw-ectool = {
        type = "app";
        program = "${self.packages.${localSystem}.fw-ectool}/bin/ectool";
      };

      packages.fw-ectool = pkgs.callPackage ./fw-ectool.nix {
        src = fw-ectool;
      };

      formatter = pkgs.alejandra;
    });
}
