{
  inputs,
  lib,
  self,
  ...
}: {
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkDefault mkEnableOption mkIf;

  cfg = config.userModules.pengo.desktop;
  system = pkgs.stdenv.hostPlatform.system;
  pkgs-self = self.packages.${system};
in {
  imports = [inputs.mangowm.nixosModules.mango];

  options.userModules.pengo.desktop = {
    enable = mkEnableOption "Enables my desktop environment & apps; currently using mangowm.";
  };

  config = mkIf cfg.enable {
    users.users.pengo.packages = with pkgs // pkgs-self; [
      godot
      librewolf
      matugen
      prismlauncher
      vesktop
      vscodium
      obsidian
    ];

    programs.mango.enable = mkDefault true;
    programs.mango.package = mkDefault pkgs-self.mango;

    services.desktopManager.gnome.enable = mkDefault true;
  };
}
