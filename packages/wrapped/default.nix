{
  inputs,
  pkgs,
  self,
  sources,
  system,
  ...
}: let
  inherit (builtins) mapAttrs pathExists;
  inherit (pkgs.lib) filterAttrs  recursiveUpdate;
  inherit (adios.lib) importModules;

  adios = import "${sources.adios}/adios";
  adios-wrappers = import sources.adios-wrappers { inherit (sources) adios; };

  root.modules = recursiveUpdate adios-wrappers (importModules ./.);

  tree = adios root {
    options = {
      "/nixpkgs" = {
        inherit pkgs;
      };
      "/flake" = {
        inherit inputs system;
        pkgs = self.packages.${system};
      };
    };
  };
in
  filterAttrs
  (package: _: pathExists ./${package}/default.nix)
  (
    mapAttrs
    (_: module: module {})
    tree.modules
  )
