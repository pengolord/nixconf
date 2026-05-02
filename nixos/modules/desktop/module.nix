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
  pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
  pkgs-unfree = import inputs.nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };
  pkgs-self = self.packages.${system};
in {
  imports = [inputs.mangowm.nixosModules.mango];

  options.userModules.pengo.desktop = {
    enable = mkEnableOption "Enables my desktop environment & apps; currently using mangowm.";
  };

  config = mkIf cfg.enable {
    users.users.pengo.packages = with pkgs-unstable // pkgs-self; [
      godot
      librewolf
      matugen
      prismlauncher
      vesktop
      vscodium
      pkgs-unfree.obsidian
    ];

    programs.mango.enable = mkDefault true;
    programs.mango.package = mkDefault pkgs-self.mango;

    services.desktopManager.gnome.enable = mkDefault true;
  };
}
