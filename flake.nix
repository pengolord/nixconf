{
  description = "Unified configuration for all of my nix-related settings, packages, nixos configurations, and more.";

  inputs = {
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = _: {};
}
