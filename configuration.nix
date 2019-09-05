{ config, pkgs, lib, ... }:

{
  boot.tmpOnTmpfs = true;
  boot.cleanTmpDir = true;
  boot.plymouth.enable = true;

  environment.systemPackages = with pkgs; [
    git libnotify

    chromium remmina vlc
    gimp inkscape krita transmission-gtk
  ] ++ (with pkgs.kdeApplications; [
    # kamoso
    okular ark dolphin dolphin-plugins k3b
    gwenview kwalletmanager kgpg akonadi akonadi-mime
    akonadi-search akonadiconsole spectacle konsole print-manager
    ksystemlog filelight kleopatra amarok
    dragon kmail
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
    desktopManager.plasma5 = {
      enable = true;
      enableQt4Support = false;
    };
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
  virtualisation.virtualbox.host.enable = true;
}
