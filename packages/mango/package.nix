{
  inputs,
  pkgs,
  system,
  ...
} @ args:
inputs.wrapper-modules.wrappers.mangowc.wrap {
  imports = [
    (import ./cursor.nix args)
  ];

  pkgs = pkgs;
  package = inputs.mangowm.packages.${system}.default;

  settings = import ./settings.nix args;
}
