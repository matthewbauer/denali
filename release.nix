{ supportedSystems ? [ "x86_64-linux" ] }:

with import <nixpkgs/pkgs/top-level/release-lib.nix> { inherit supportedSystems; };
with import <nixpkgs/lib>;

{

  # Live CD (no installer currently!)
  live_iso = forMatchingSystems supportedSystems (system:
    hydraJob ((import <nixpkgs/nixos/lib/eval-config.nix> {
      inherit system;
      modules = [
        <nixpkgs/nixos/modules/installer/cd-dvd/iso-image.nix>
        ./demo.nix
        ./configuration.nix
      ];
    }).config.system.build.isoImage));

  # Minimal installer ISO
  installer_iso = forMatchingSystems supportedSystems (system:
    hydraJob ((import <nixpkgs/nixos/lib/eval-config.nix> {
      inherit system;
      modules = [
        <nixpkgs/nixos/modules/installer/cd-dvd/iso-image.nix>
        ./demo.nix
        ./installer.nix
      ];
    }).config.system.build.isoImage));

  # A bootable VirtualBox virtual appliance as an OVA file (i.e. packaged OVF).
  ova = forMatchingSystems supportedSystems (system:
    hydraJob ((import <nixpkgs/nixos/lib/eval-config.nix> {
      inherit system;
      modules = [
        <nixpkgs/nixos/modules/virtualisation/virtualbox-image.nix>
        ./demo.nix
        ./ova.nix
        ./configuration.nix
      ];
    }).config.system.build.virtualBoxOVA));

}
