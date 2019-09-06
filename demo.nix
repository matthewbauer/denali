{ ... }:

{

  users.users.demo =
    { isNormalUser = true;
      description = "Demo user account";
      extraGroups = [ "wheel" ];
      password = "demo";
      uid = 1000;
    };

  services.xserver.displayManager.sddm.autoLogin = {
    enable = true;
    relogin = true;
    user = "demo";
  };

  # Whitelist wheel users to do anything
  # This is useful for things like pkexec
  #
  # WARNING: this is dangerous for systems
  # outside the installation-cd and shouldn't
  # be used anywhere else.
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (subject.isInGroup("wheel")) {
        return polkit.Result.YES;
      }
    });
  '';

  nix.trustedUsers = [ "demo" ];
}
