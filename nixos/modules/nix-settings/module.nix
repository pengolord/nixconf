{
  inputs,
  lib,
  ...
}: {
  config,
  pkgs,
  ...
}: let
  inherit (lib) getName mkEnableOption mkIf;

  cfg = config.nix;
  system = pkgs.stdenv.hostPlatform.system;
  pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
in {
  options.nix.apple-silicon.enable = mkEnableOption "Enables the apple-silicon chachix repo.";

  config = {
    nix.package = pkgs-unstable.lixPackageSets.stable.lix;
    nix.settings = {
      experimental-features = ["nix-command" "flakes"];

      extra-substituters = mkIf cfg.apple-silicon.enable [
        "https://nixos-apple-silicon.cachix.org"
      ];

      extra-trusted-public-keys = mkIf cfg.apple-silicon.enable [
        "nixos-apple-silicon.cachix.org-1:8psDu5SA5dAD7qA0zMy5UT292TxeEPzIz8VVEr2Js20="
      ];
    };

    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (getName pkg) [
        "nvidia-x11"
        "nvidia-settings"
        "steam"
        "steam-unwrapped"
        "obsidian"
      ];
  };
}
