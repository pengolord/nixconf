{
  lib,
  self,
  ...
} @ args: let
  inherit (lib) nixosSystem;

  mkHost = path:
    nixosSystem {
      modules = [
        self.nixosModules.shared
        path
      ];
      specialArgs = args;
    };
in {
  amethyst = mkHost ./amethyst/configuration.nix;
  granite = mkHost ./granite/configuration.nix;
  quartz = mkHost ./quartz/configuration.nix;
}
