{ inputs, pkgs-unstable, ... }:

let
  wrapper = inputs.wrapper-modules.lib.evalModule ./module.nix;
in
wrapper.config.wrap {
  pkgs = pkgs-unstable;

  configFile.content = import ./templates;
}
