{
  inputs,
  pkgs,
  ...
}: let
  wrapper = inputs.wrapper-modules.lib.evalModule ./wrapper.nix;
in
  wrapper.config.wrap {
    inherit pkgs;

    configFile.content = import ./templates;
  }
