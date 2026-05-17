{
  config,
  lib,
  ...
}: let
  cfg = config.userModules.pengo;
  inherit (cfg._args) pkgs;
  inherit (lib) getName mkEnableOption mkIf;
in {
  options.nix.apple-silicon.enable = mkEnableOption "Enables the apple-silicon cachix repo.";

  config = {
    nix.package = pkgs.lixPackageSets.stable.lix;
    nix.settings = {
      experimental-features = ["nix-command" "flakes"];

      extra-substituters = mkIf config.nix.apple-silicon.enable [
        "https://nixos-apple-silicon.cachix.org"
      ];

      extra-trusted-public-keys = mkIf config.nix.apple-silicon.enable [
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
