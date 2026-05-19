{
  description = "Unified configuration for all of my nix-related settings, packages, nixos configurations, and more.";

  inputs = {
    # Package Repositories
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # System Dependencies
    apple-silicon.url = "github:tpwrules/nixos-apple-silicon";
  };

  outputs = inputs: import ./. inputs;
}
