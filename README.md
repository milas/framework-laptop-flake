# Framework Flake
Random software I've packaged for use on NixOS that's primarily useful for my Framework 13 Ryzen.

## `fw-ectool`: fork of `ectool` with extra Framework support
You can try it with `nix run github:milas/framework-laptop-flake#fw-ectool`.

For example:
```shell
❯ sudo nix run github:milas/framework-laptop-flake#fw-ectool version
RO version:    azalea_v3.4.113353-ec:b4c1fb,os
RW version:    azalea_v3.4.113353-ec:b4c1fb,os
Firmware copy: RO
Build info:    azalea_v3.4.113353-ec:b4c1fb,os:7b88e1,cmsis:4aa3ff 2024-03-26 07:10:22 lotus@ip-172-26-3-226
Tool version:  0.0.1-isolate Jan  1 1980 none
```

Upstream repository: https://gitlab.howett.net/DHowett/ectool
