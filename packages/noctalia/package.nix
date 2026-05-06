{
  inputs,
  lib,
  pkgs,
  system,
  ...
}:
inputs.wrapper-modules.wrappers.noctalia-shell.wrap (
  {config, ...}: {
    inherit pkgs;
    package = inputs.noctalia-shell.packages.${system}.default;

    outOfStoreConfig = "/home/pengo/.config/noctalia";

    constructFiles.user-templates = lib.mkForce {
      content = import ../matugen/templates;
      relPath = "${config.generatedConfigDirname}/user-templates.toml";
    };
  }
)
