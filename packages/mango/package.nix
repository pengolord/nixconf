{
  inputs,
  lib,
  pkgs-unstable,
  system,
  ...
} @ args: let
  inherit (pkgs-unstable) bibata-cursors;
in
  inputs.wrapper-modules.wrappers.mangowc.wrap ({config, ...}: {
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
          description = "Theme name of the cursor within the package.";
        };

        size = mkOption {
          type = types.int;
          default = 24;
        };
      };
    };

    config = {
      pkgs = pkgs-unstable;
      package = inputs.mangowm.packages.${system}.default;

      settings =
        (import ./settings.nix args)
        // {
          cursor_theme = config.cursor.theme;
          cursor_size = config.cursor.size;

          env = [
            "XCURSOR_THEME,${config.cursor.theme}"
            "XCURSOR_SIZE,${toString config.cursor.size}"
          ];
        };
    };
  })
