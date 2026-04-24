{ inputs, lib, ... }:

{ pkgs, ... }: let
  system = pkgs.stdenv.hostPlatform.system;
  pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
in {
  nix.package = pkgs-unstable.lixPackageSets.stable.lix;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings = {
    extra-substituters = [
      "https://nixos-apple-silicon.cachix.org"
    ];

    extra-trusted-public-keys = [
      "nixos-apple-silicon.cachix.org-1:8psDu5SA5dAD7qA0zMy5UT292TxeEPzIz8VVEr2Js20="
    ];
  };

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "nvidia-x11"
      "nvidia-settings"
      "steam"
      "steam-unwrapped"
      "obsidian"
    ];
}
