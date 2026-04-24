{ lib, ... }:

{ config, ... }: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.userModules.pengo;
in {
  options.userModules.pengo = {
    enable = mkEnableOption "Adds pengo as a user.";
    isAdministrator = mkEnableOption "Adds pengo to the 'wheel' group, among other privileges.";
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
