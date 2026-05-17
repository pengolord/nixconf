{
  config,
  lib,
  ...
}: let
  cfg = config.userModules.pengo;
  inherit (cfg._args) pkgs;
  inherit (lib) mkEnableOption mkIf;
in {
  options.boot.plymouthWithCuts.enable = mkEnableOption "Enables the apple-silicon cachix repo.";

  config = mkIf config.boot.plymouthWithCuts.enable {
    boot = {
      plymouth = {
        enable = true;
        theme = "cuts";
        themePackages = with pkgs; [
          (adi1090x-plymouth-themes.override {
            selected_themes = ["cuts"];
          })
        ];
      };

      consoleLogLevel = 3;
      initrd.verbose = false;
      kernelParams = [
        "quiet"
        "udev.log_level=3"
        "systemd.show_status=auto"
      ];
    };
  };
}
