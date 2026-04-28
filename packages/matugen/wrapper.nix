{
  config,
  pkgs,
  lib,
  wlib,
  ...
}: {
  imports = [wlib.modules.default];

  options = {
    configFile = lib.mkOption {
      type = wlib.types.file pkgs;
      description = ''
        Config file that matugen will use as its config file.
      '';
      default.path = config.constructFiles.generatedConfig.path;
      default.content = "";
    };
  };

  config = {
    package = lib.mkDefault pkgs.matugen;

    constructFiles.generatedConfig = {
      relPath = "matugen.toml";
      content = config.configFile.content or "";
    };

    flags."-c" = config.configFile.path;
  };
}
