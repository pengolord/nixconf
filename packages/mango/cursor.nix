{
  lib,
  pkgs-unstable,
  ...
}: let
  inherit (pkgs-unstable) bibata-cursors;
in
  {config, ...}: {
    options = let
      inherit (lib) mkOption types;
    in {
      cursor = {
        package = mkOption {
          type = types.package;
          default = bibata-cursors;
        };

        theme = mkOption {
          type = types.str;
          default = "Bibata-Modern-Ice";
          description = "Theme name of the cursor theme within the package.";
        };

        size = mkOption {
          type = types.int;
          default = 24;
        };
      };
    };

    config = let
      cfg = config.cursor;
    in {
      settings = {
        cursor_theme = cfg.theme;
        cursor_size = cfg.size;

        env = [
          "XCURSOR_PATH,${cfg.package}/share/icons"
          "XCURSOR_THEME,${cfg.theme}"
          "XCURSOR_SIZE,${toString cfg.size}"
        ];
      };
    };
  }
