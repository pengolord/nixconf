{
  description = "Unified configuration for all of my nix-related settings, packages, nixos configurations, and more.";

  inputs = {
    # === Package Repositories ===
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # === System Dependencies ===
    apple-silicon.url = "github:tpwrules/nixos-apple-silicon";
    impermanence.url = "github:nix-community/impermanence";

    # === Helpers ===
    wrapper-modules.url = "github:Pengolord/nix-wrapper-modules";
    agenix = {
      url = "github:ryantm/agenix";
      inputs.home-manager.follows = "";
      inputs.darwin.follows = "";
    };

    # === Program Repositories ===
    noctalia-shell.url = "github:noctalia-dev/noctalia-shell";
    mangowm = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = {self, ...} @ inputs: let
    lib = inputs.nixpkgs-stable.lib;

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
        pkgs-stable = inputs.nixpkgs-stable.legacyPackages.${system};
        pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
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

    formatter = forEachSystem (system: inputs.nixpkgs-stable.legacyPackages.${system}.alejandra);
  };
}
