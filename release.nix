{ supportedSystems ? [ "x86_64-linux" ] }:

with import <nixpkgs/pkgs/top-level/release-lib.nix> { inherit supportedSystems; };
with import <nixpkgs/lib>;

{

  iso = forMatchingSystems [ "x86_64-linux" ] (system:
    hydraJob ((import <nixpkgs/nixos/lib/eval-config.nix> {
      inherit system;
      modules = [
        <nixpkgs/nixos/modules/installer/cd-dvd/iso-image.nix>
        ./demo.nix
        ./configuration.nix
      ];
    }).config.system.build.isoImage));

  # A bootable VirtualBox virtual appliance as an OVA file (i.e. packaged OVF).
  ova = forMatchingSystems [ "x86_64-linux" ] (system:
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
