{ config, pkgs, ... }:

# A minimal NixOS configuration to install NixOS. Network access is
# required.

let
  installer = pkgs.callPackage ./installer {};
in {

  imports = [ <nixpkgs/nixos/modules/profiles/all-hardware.nix> ];

  hardware.opengl.enable = true;
  fonts.enableDefaultFonts = true;

  environment.systemPackages = [
    pkgs.dbus
    pkgs.hicolor-icon-theme
    installer
  ];

  gtk.iconCache.enable = true;

  services.dbus.enable = true;

  # systemd.services."serial-getty@ttyS0".enable = false;
  # systemd.services."serial-getty@hvc0".enable = false;
  # systemd.services."getty@tty1".enable = false;
  # systemd.services."autovt@".enable = false;

  systemd.services.display-manager = {
    enable = true;
    after = [ "systemd-udev-settle.service" "acpid.service" "systemd-logind.service" ];
    wants = [ "systemd-udev-settle.service" ];
    environment = {
      XDG_SESSION_TYPE = "wayland";
      NIXOS_MANUAL = config.system.build.manual.manualHTMLIndex;
    };
    script = ''
      export PATH=${pkgs.dbus}/bin:$PATH
      ${pkgs.dbus}/bin/dbus-run-session ${pkgs.cage}/bin/cage ${pkgs.xterm}/bin/xterm
    '';
    restartIfChanged = false;
    serviceConfig = {
      User = "demo";
      Restart = "always";
      RestartSec = "200ms";
      StartLimitInterval = "30s";
      StartLimitBurst = "3";
    };
  };

  systemd.defaultUnit = "graphical.target";
  xdg.icons.enable = true;

  hardware.enableRedistributableFirmware = true;
  boot.plymouth.enable = true;
  services.udisks2.enable = false;

  # Hack around Nix’s bad memory management
  environment.variables.GC_INITIAL_HEAP_SIZE = "1M";
  boot.kernel.sysctl."vm.overcommit_memory" = "1";
  boot.kernel.sysctl."fs.inotify.max_user_watches" = 524288;

}
