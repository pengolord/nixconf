{
  inputs,
  lib,
  pkgs-unstable,
  system,
  ...
} @ args:
inputs.wrapper-modules.wrappers.mangowc.wrap {
  imports = [
    (import ./cursor.nix args)
  ];

  pkgs = pkgs-unstable;
  package = inputs.mangowm.packages.${system}.default;

  settings = import ./settings.nix args;
}
