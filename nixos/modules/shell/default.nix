{
  lib,
  self,
  ...
}: {
  config,
  pkgs,
  ...
}: let
  inherit (lib) getExe mkDefault mkIf mkOption types;

  cfg = config.userModules.pengo.shell;
  system = pkgs.stdenv.hostPlatform.system;
  pkgs-self = self.packages.${system};

  inherit (pkgs-self) git neovim nushell;
in {
  options.userModules.pengo.shell = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Sets up nushell & sets my shell to my wrapped version of it.";
    };
  };

  config = mkIf cfg.enable {
    programs.nano.enable = mkDefault false;
    programs.direnv.enable = mkDefault true;

    users.users.pengo = {
      shell = getExe nushell;
      packages = [git neovim nushell];
    };
  };
}
