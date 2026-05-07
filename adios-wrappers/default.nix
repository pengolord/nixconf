{
  inputs,
  lib,
  pkgs,
  ...
}: let
  inherit (inputs.adios) adios;
  inherit (inputs.adios-wrappers) wrapperModules;
  inherit (builtins) mapAttrs pathExists;
  inherit (lib) filterAttrs recursiveUpdate;

  overrides = adios.lib.importModules ./.;

  root = {
    modules = recursiveUpdate wrapperModules overrides;
  };

  tree = adios root {
    options = {
      "/nixpkgs" = {
        inherit pkgs;
      };
    };
  };
in
  filterAttrs (key: _: pathExists ./${key}/default.nix) (mapAttrs (_: module: module {}) tree.modules)
