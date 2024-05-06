# Flake for Framework Laptop Systems
Random software I've packaged for use on NixOS that's primarily useful for my Framework 13 Ryzen.

> [!IMPORTANT]
> I have no affiliation with or endorsement from Framework Computer Inc.
> 
> Tools in this repository often require elevated permissions and could cause permanent harm or unexpected side effects if used improperly.
> 
> Tinker safely!

Unless otherwise indicated, I didn't actually write any of these tools, I'm merely packaging them for NixOS (probably poorly).

## `fw-ectool`: fork of `ectool` with extra Framework support
Upstream repository: https://gitlab.howett.net/DHowett/ectool

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

## `framework-system`: Rust library & CLI tools
Upstream repository: https://github.com/FrameworkComputer/framework-system

### `framework_tool`
You can try it with `nix run github:milas/framework-laptop-flake#framework-tool`.

For example:
```shell
❯ sudo nix run github:milas/framework-laptop-flake#framework-tool -- --driver=portio --info
BIOS Information
Vendor:       INSYDE Corp.
Version:      03.05
Release Date: 03/29/2024
System Information
Version:      A7
Manufacturer: Framework
Product Name: Laptop 13 (AMD Ryzen 7040Series)
Wake-Up-Type: PowerSwitch
SKU Number:   FRANDGCP07
Family:       Laptop
```

## `keylightd`:  keyboard backlight daemon for the Framework Laptop
⚠️ I had to fork `keylightd` because it no longer compiles on a modern Rust compiler and is unmaintained.

⚠️ `keylightd` is not currently compatible with the AMD model.

Upstream repository: https://code.notaphish.fyi/milas/keylightd
(Original) upstream repository: https://github.com/jonas-schievink/keylightd

You can try it with `nix run github:milas/framework-laptop-flake#keylightd`.

⚠️ There's no NixOS module/systemd service provided.

For example:
```shell
❯ nix run github:milas/framework-laptop-flake#keylightd -- --help
Usage: keylightd [--brightness <brightness>] [--timeout <timeout>] [--power]

keylightd - automatic keyboard backlight daemon for Framework laptops

Options:
--brightness      brightness level when active (0-100) [default=30]
--timeout         activity timeout in seconds [default=10]
--power           also control the power LED in the fingerprint module
--help            display usage information
```
