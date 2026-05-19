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
  };

  outputs = inputs: import ./. inputs;
}
