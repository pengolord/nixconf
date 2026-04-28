{
  inputs,
  pkgs-unstable,
  ...
}: let
  wrapper = inputs.wrapper-modules.lib.evalModule ./wrapper.nix;
in
  wrapper.config.wrap {
    pkgs = pkgs-unstable;

    configFile.content = import ./templates;
  }
