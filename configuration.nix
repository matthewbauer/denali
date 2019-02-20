{ config, pkgs, lib, ...  }:

{
  environment.systemPackages = with pkgs; [
    chromium remmina vlc virtualbox
  ] ++ (with pkgs.kdeApplications; [
    okular ark dolphin dolphin-plugins k3b
    gwenview kwalletmanager kgpg akonadi akonadi-mime
    akonadi-search akonadiconsole spectacle konsole print-manager
    ksystemlog filelight kleopatra
  ]);

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
  networking.firewall.enable = true;
  programs.zsh.enable = true;
  services.virtualbox.host.enable = true;

  services.xserver = {
    enable = true;
    autorun = true;
    libinput = {
      enable = true;
      disableWhileTyping = true;
    };
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
    desktopManager.plasma5.enableQt4Support = false;
  };

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

}
