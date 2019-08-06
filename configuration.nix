{ config, pkgs, lib, ... }:

{
  boot.tmpOnTmpfs = true;

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

  services.colord.enable = true;

  services.flatpak.enable = true;

  boot.cleanTmpDir = true;
  programs.ssh.startAgent = true;
  programs.gnupg.agent.enable = true;
  nixpkgs.config.allowUnfree = true;
  hardware.enableRedistributableFirmware = true;
  hardware.bluetooth.enable = true;
  boot.plymouth.enable = true;
  networking.networkmanager.enable = true;
  fonts.enableDefaultFonts = true;
  fonts.enableFontDir = true;
  services.printing = {
    enable = true;
    webInterface = false;
  };
  networking.firewall.enable = false;
  programs.zsh.enable = true;
  # virtualisation.virtualbox.host = {
  #   enable = true;
  #   enableExtensionPack = true;
  # };
  powerManagement.enable = true;

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
    publish = {
      enable = true;
      userServices = true;
    };
  };

  powerManagement.cpuFreqGovernor = null;
  services.tlp.enable = true;
  services.fwupd.enable = true;
  virtualisation.virtualbox.host.enable = true;

  services.earlyoom.enable = true;

}