{ config, pkgs, lib, ... }:

{
  boot.tmpOnTmpfs = true;
  boot.cleanTmpDir = true;
  boot.plymouth.enable = true;

  environment.systemPackages = with pkgs; [
    git libnotify

    chromium
    remmina vlc
    gimp inkscape transmission-gtk
    # blender krita

    gnome3.adwaita-icon-theme
    gnome3.gnome-keyring
  ] ++ (with pkgs.kdeApplications; [
    # kamoso
    okular ark dolphin dolphin-plugins k3b
    gwenview kwalletmanager kgpg akonadi akonadi-mime
    ksshaskpass
    akonadi-search akonadiconsole spectacle konsole print-manager
    ksystemlog filelight kleopatra amarok
    dragon kmail kcalc konqueror akregator kate
  ]) ++ (with pkgs.kdeFrameworks; [
    baloo
  ]);

  nixpkgs.config.allowUnfree = true;

  hardware.enableRedistributableFirmware = true;
  hardware.bluetooth.enable = true;

  services.earlyoom.enable = true;
  powerManagement.enable = true;
  services.tlp.enable = true;

  services.flatpak.enable = true;
  programs.ssh.startAgent = true;
  programs.gnupg.agent.enable = true;
  networking.networkmanager.enable = true;
  fonts.enableDefaultFonts = true;
  fonts.enableFontDir = true;
  services.colord.enable = true;
  services.printing = {
    enable = true;
    webInterface = false;
  };
  networking.firewall.enable = false;
  programs.zsh.enable = true;

  services.xserver = {
    enable = true;
    autorun = true;
    libinput.enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
  };

  nix.distributedBuilds = true;

  services.openssh.enable = true;
  hardware.pulseaudio.enable = true;
  services.samba.enable = true;
  services.avahi = {
    enable = true;
    nssmdns = true;
    extraServiceFiles = {
      ssh = "${pkgs.avahi}/etc/avahi/services/ssh.service";
    };
    publish = {
      enable = true;
      userServices = true;
    };
  };

  services.fwupd.enable = true;
  # virtualisation.virtualbox.host.enable = true;

  nix.package = pkgs.nixUnstable;
  nix.extraOptions = ''
    min-free = ${toString (1 * 1024 * 1024 * 1024)}
    max-free = ${toString (5 * 1024 * 1024 * 1024)}
    experimental-features = nix-command flakes recursive-nix ca-references
  '';

  boot.kernel.sysctl."kernel.sysrq" = 176;

  services.localtime.enable = true;

}
