{
  config,
  lib,
  ...
}: let
  cfg = config.userModules.pengo;
  inherit (cfg._args) pkgs pkgs-self;
  inherit (lib) getExe mkDefault mkIf mkOption types;
in {
  options.userModules.pengo.shell = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Sets up nushell & sets my shell to my wrapped version of it.";
    };
  };

  config = mkIf (cfg.enable && cfg.shell.enable) {
    programs.nano.enable = mkDefault false;
    programs.direnv.enable = mkDefault true;

    users.users.pengo = {
      shell = getExe pkgs-self.nushell;
      packages = with pkgs // pkgs-self; [
        comma
        git
        neovim
        nh
        nushell
      ];
    };
  };
}
