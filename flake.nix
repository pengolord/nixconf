{
  description = "Unified configuration for all of my nix-related settings, packages, nixos configurations, and more.";

  inputs = {
    # Package Repositories
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    noctalia-shell.url = "github:noctalia-dev/noctalia-shell/v5";
    mangowm = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # System Dependencies
    apple-silicon.url = "github:tpwrules/nixos-apple-silicon";
    impermanence.url = "github:nix-community/impermanence";

    # Helpers
    agenix = {
      url = "github:ryantm/agenix";
      inputs.home-manager.follows = "";
      inputs.darwin.follows = "";
    };
    adios.follows = "adios-wrappers/adios";
    adios-wrappers.url = "github:llakala/adios-wrappers";
    mnw.url = "github:Gerg-L/mnw";
  };

  outputs = {
    nixpkgs,
    self,
    ...
  } @ inputs: let
    inherit (nixpkgs) lib;

    # Each system that this configuration's packages & other system-dependant outputs support.
    systems = [
      "x86_64-linux"
      "aarch64-linux"
    ];

    # Arguments that are passed to every imported file that does not require 'system' to be set.
    args = {
      inherit inputs lib self;
    };

    # Arguments that are passed to every imported file that *does* require 'system' to be set. Includes all of the previous arguments too.
    getArgsFor = system:
      args
      // {
        inherit system;
        pkgs = nixpkgs.legacyPackages.${system};
        pkgs-self = self.packages.${system};
      };

    forEachSystem = lib.genAttrs systems;
  in {
    nixosConfigurations = import ./nixos/hosts args;

    nixosModules = import ./nixos/modules args;

    packages = forEachSystem (
      system:
        import ./packages (getArgsFor system)
    );

    devShells = forEachSystem (
      system: let
        pkgs = inputs.nixpkgs.legacyPackages.${system};
      in {
        default = pkgs.mkShellNoCC {
          allowSubstitutes = false;
          packages = builtins.attrValues self.packages.${system};
        };
      }
    );

    formatter = forEachSystem (system: nixpkgs.legacyPackages.${system}.alejandra);
  };
}
