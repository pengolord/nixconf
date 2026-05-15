{config, lib, pkgs, ...} @ moduleArgs: let
  cfg = config.userModules.pengo;
  inherit (cfg._args) pkgs-self pkgs;
  inherit (lib) mkDefault mkEnableOption mkIf;
in {
  options.userModules.pengo.desktop = {
    enable = mkEnableOption "Enables my desktop environment & apps; currently using mangowm.";
  };

  config = mkIf (cfg.enable && cfg.desktop.enable) {
    users.users.pengo.packages = with pkgs // pkgs-self; [
      godot
      librewolf
      matugen
      prismlauncher
      vesktop
      vscodium
      moduleArgs.pkgs.obsidian # allows for unfree to work, but does not pin the package
    ];

    programs.mango.enable = mkDefault true;
    programs.mango.package = mkDefault pkgs-self.mangowc;

    services.desktopManager.gnome.enable = mkDefault true;
  };
}
