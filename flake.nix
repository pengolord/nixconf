{
  description = "Unified configuration for all of my nix-related settings, packages, nixos configurations, and more.";

  inputs = {
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";
  };

  outputs = { self, ... } @inputs: let
    lib = inputs.nixpkgs-stable.lib;

    # Each system that this configuration's packages & other system-dependant outputs support.
    systems = [ "x86_64-linux" "aarch64-linux" ];

    # Arguments that are passed to every imported file that does not require 'system' to be set.
    args = {
      inherit inputs lib self;
    };

    # Arguments that are passed to every imported file that *does* require 'system' to be set. Includes all of the previous arguments too.
    getArgsFor = system:
      args // {
        inherit system;
        pkgs-stable = inputs.nixpkgs-stable.legacyPackages.${system};
        pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
        pkgs-self = self.packages.${system};
      };

    forEachSystem = perSystem:
      lib.genAttrs systems perSystem;
  in {
    packages = forEachSystem (system:
      import ./packages (getArgsFor system)
    );
  };
}
