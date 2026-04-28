{
  lib,
  self,
  ...
} @ args: let
  inherit (lib) genAttrs nixosSystem;
  inherit (builtins) attrNames filter pathExists readDir;
  contentsOf = dir: attrNames (readDir dir);

  # Gets the name of every sibling directory that has a 'configuration.nix' file.
  hasConfigFile = path: pathExists ./${path}/configuration.nix;
  hostnames = filter hasConfigFile (contentsOf ./.);

  mkConfig = hostname:
    nixosSystem {
      modules = [
        self.nixosModules.nix-settings
        ./${hostname}/configuration.nix
      ];

      specialArgs = args;
    };

  nixosConfigurations = genAttrs hostnames mkConfig;
in
  nixosConfigurations
