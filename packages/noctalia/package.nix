{ inputs, lib, pkgs-self, pkgs-unstable, system, ... }:

inputs.wrapper-modules.wrappers.noctalia-shell.wrap({ config, ...}: {
  pkgs = pkgs-unstable;
  package = inputs.noctalia-shell.packages.${system}.default;

  outOfStoreConfig = "/home/pengo/.config/noctalia";

  constructFiles.user-templates = lib.mkForce {
    content = import ../matugen/templates;
    relPath = "${config.generatedConfigDirname}/user-templates.toml";
  };
})
