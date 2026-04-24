{ inputs, lib, pkgs-self, pkgs-unstable, system, ... }:

let
  inherit (lib) getExe;

  inherit (pkgs-unstable) bibata-cursors;
  inherit (pkgs-self) kitty;
  noctalia = inputs.noctalia-shell.packages.${system}.default;
in
inputs.wrapper-modules.wrappers.mangowc.wrap {
  pkgs = pkgs-unstable;
  package = inputs.mangowm.packages.${system}.default;

  sourcedFiles = [
    ./binds.conf
    ./layout.conf
    ./misc.conf
    ./style.conf
  ];

  extraContent = ''
    # === Startup Programs ===
    exec-once = ${getExe noctalia}

    # === Keybinded Programs & Program-Related Commands ===
    bind = super, return, spawn, ${getExe kitty}
    bind = super, space, spawn, ${getExe noctalia} ipc call launcher toggle
    # Media keys
    bind = none, XF86AudioRaiseVolume, spawn, ${getExe noctalia} ipc call volume increase
    bind = none, XF86AudioLowerVolume, spawn, ${getExe noctalia} ipc call volume decrease
    bind = none, XF86AudioMute, spawn, ${getExe noctalia} ipc call volume muteOutput
    bind = none, XF86MonBrightnessUp, spawn, ${getExe noctalia} ipc call brightness increase
    bind = none, XF86MonBrightnessDown, spawn, ${getExe noctalia} ipc call brightness decrease

    cursor_theme = Bibata-Modern-Ice
    cursor_size = 24
  '';

  env.XCURSOR_SIZE = "24";
  env.XCURSOR_THEME = "Bibata-Modern-Ice";

  extraPackages = [ bibata-cursors ];
}
