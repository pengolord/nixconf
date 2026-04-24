{ lib, self, ... }:

{ config, pkgs, ... }: let
  inherit (lib) getExe mkDefault mkIf mkOption types;

  cfg = config.userModules.pengo.shell;
  system = pkgs.stdenv.hostPlatform.system;
  pkgs-self = self.packages.${system};

  inherit (pkgs-self) git neovim zsh;
in {
  options.userModules.pengo.shell = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Sets up zsh & sets pengo's shell to pengo's wrapped version of it.";
    };
  };

  config = mkIf cfg.enable {
    programs.nano.enable = mkDefault false;
    programs.zsh.enable = mkDefault true;
    environment.pathsToLink = [ "/share/zsh" ];

    users.users.pengo = {
      shell = getExe zsh;
      packages = [ git neovim zsh ];
    };
  };
}
