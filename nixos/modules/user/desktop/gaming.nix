{config, lib, ...}: let
  cfg = config.userModules.pengo;
  inherit (cfg._args) pkgs-self pkgs;
  inherit (lib) mkDefault mkEnableOption mkIf;
in {
  options.userModules.pengo.desktop.gaming = {
    enable = mkEnableOption "Enables my desktop environment & apps; currently using mangowm.";
  };

  config = mkIf (cfg.enable && cfg.desktop.enable && cfg.desktop.gaming.enable) {
    programs.steam.enable = mkDefault true;
    users.users.pengo.packages = with pkgs // pkgs-self; [
      prismlauncher
    ];
  };
}
