{
  self,
  pkgs,
  ...
}: {
  imports = [self.nixosModules.user];

  programs.fish.enable = true;

  userModules.pengo = {
    enable = true;
    isAdministrator = true;
  };

  users.users = {
    pengo.extraGroups = ["docker"];

    pengo = {
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMnwLtO0ONDPGXckgw2HrGfFNZJNXlYQhuUjqfJEZl4r pengo@amethyst"
      ];
    };

    "0m3n" = {
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK9Cxo/Hc5FbCh5j9VPqTbVYRbEUCFBEOixIh73+clKk"
      ];

      shell = pkgs.fish;
    };

    prism = {
      isNormalUser = true;
    };

    gran = {
      isNormalUser = true;
    };
  };

  users.groups = {
    git = {
      members = [
        "pengo"
        "0m3n"
        "prism"
        "gran"
      ];
    };
  };
}
