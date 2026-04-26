{ lib, self, ... }:

{ config, ... }: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.userModules.pengo;
in {
  imports = [
    self.nixosModules.shell
    self.nixosModules.desktop
    self.nixosModules.secrets
  ];

  options.userModules.pengo = {
    enable = mkEnableOption "Adds my user (pengo) as a user.";
    isAdministrator = mkEnableOption "Adds my user to the 'wheel' group, among other privileges.";
  };

  config = mkIf cfg.enable {
    nix.settings.allowed-users = mkIf cfg.isAdministrator [ "pengo" ];
    nix.settings.trusted-users = mkIf cfg.isAdministrator [ "pengo" ];

    users.users.pengo = {
      isNormalUser = true;
      extraGroups = [
        "inputs"
        "audio"
        "video"
        "networkmanager"
      ] ++ (
        if cfg.isAdministrator
        then [ "wheel" ]
        else [ ]
      );
    };
  };
}
