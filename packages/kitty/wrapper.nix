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
        Config file that kitty will use as its config file.
      '';
      default.path = config.constructFiles.generatedConfig.path;
      default.content = "";
    };
  };

  config = {
    package = lib.mkDefault pkgs.kitty;

    constructFiles.generatedConfig = {
      relPath = "kitty.conf";
      content = config.configFile.content or "";
    };

    flags."--config" = config.configFile.path;
  };
}
