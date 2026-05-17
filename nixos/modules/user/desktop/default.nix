{
  config,
  lib,
  pkgs,
  ...
} @ moduleArgs: let
  cfg = config.userModules.pengo;
  inherit (cfg._args) pkgs-self pkgs;
  pkgs-unpinned = moduleArgs.pkgs;
  inherit (lib) mkDefault mkEnableOption mkIf;
in {
  imports = [
    ./gaming.nix
  ];

  options.userModules.pengo.desktop = {
    enable = mkEnableOption "Enables my desktop environment & apps; currently using mangowm.";
  };

  config = mkIf (cfg.enable && cfg.desktop.enable) {
    users.users.pengo.packages = with pkgs // pkgs-self; [
      godot
      librewolf
      matugen
      vesktop
      pkgs-unpinned.obsidian # allows for unfree to work, but does not pin the package
    ];

    programs.mango.enable = mkDefault true;
    programs.mango.package = mkDefault pkgs-self.mangowc;

    services.desktopManager.gnome.enable = mkDefault true;
  };
}
