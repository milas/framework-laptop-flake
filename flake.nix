{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # we just need ectool which was split into own repo at DHowett/ectool
    #    framework-ec = {
    #      url = "github:DHowett/framework-ec";
    #      flake = false;
    #    };

    crane = {
      url = "github:ipetkov/crane";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    keylightd = {
      # keep tag in sync in outputs below
      # see https://github.com/NixOS/nix/issues/3838 / I don't understand flakes
      #url = "github:jonas-schievink/keylightd/v1.1.0";
      url = "git+https://code.notaphish.fyi/milas/keylightd";
      flake = false;
    };

    framework-cpu-usage-led = {
      url = "github:gamingdoom/framework-cpu-usage-led";
      flake = false;
    };

    framework-system = {
      url = "github:FrameworkComputer/framework-system";
      flake = false;
    };

    fw-ectool = {
      url = "gitlab:DHowett/ectool?host=gitlab.howett.net";
      flake = false;
    };

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    crane,
    fw-ectool,
    flake-utils,
    framework-system,
    keylightd,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (localSystem: let
      pkgs = nixpkgs.legacyPackages.${localSystem};

      craneLib = crane.lib.${localSystem};

      fwsysPkgs = pkgs.callPackage ./framework-system.nix {
        inherit craneLib;
        src = framework-system;
      };
    in {
      apps.fw-ectool = {
        type = "app";
        program = "${self.packages.${localSystem}.fw-ectool}/bin/ectool";
      };

      apps.keylightd = {
        type = "app";
        program = "${self.packages.${localSystem}.keylightd}/bin/keylightd";
      };

      apps.framework-tool = flake-utils.lib.mkApp {
        drv = fwsysPkgs.framework-tool;
      };

      packages.fw-ectool = pkgs.callPackage ./fw-ectool.nix {
        src = fw-ectool;
      };

      packages.keylightd = pkgs.callPackage ./keylightd.nix {
        inherit craneLib;
        src = keylightd;
      };

      packages.framework-tool = fwsysPkgs.framework-tool;

      formatter = pkgs.alejandra;
    });
}
