{
  lib,
  pkgs-unstable,
  pkgs-self,
  ...
}: let
  inherit (lib) getExe;
  inherit (builtins) concatLists genList;

  inherit (pkgs-unstable) grim wl-clipboard;
  inherit (pkgs-self) kitty noctalia;

  forTag1to9 = f: genList (i: f (toString (i + 1))) 9;
in {
  # === Startup Programs ===
  exec-once = "${getExe noctalia}";

  # === Keybinds ===
  bind = concatLists [
    # Super + 1-9 switches to tag 1-9
    (forTag1to9 (tag: "super, ${tag}, view, ${tag}, 0"))

    # Super + Shift + 1-9 switches to tag 1-9, and moves the current window along
    (forTag1to9 (tag: "super+shift, ${tag}, tag, ${tag}, 0"))

    [
      # Switch window focus
      "super, tab, focuslast,"
      "super, h, focusdir, left"
      "super, j, focusdir, down"
      "super, k, focusdir, up"
      "super, l, focusdir,right"

      # Swap windows around
      "super+shift, h, exchange_client, left"
      "super+shift, j, exchange_client, down"
      "super+shift, k, exchange_client, up"
      "super+shift, l, exchange_client, right"

      # Switch window mode (plus = fullscreen, minus = floating)
      "super, equal, togglefullscreen,"
      "super, minus, togglefloating,"

      # Super + 0 views all tags at once
      "super, 0, view, 0, 0"

      # Close windows
      "super, backspace, killclient,"

      # Resize windows
      "super+alt, up, resizewin, +0, -50"
      "super+alt, down, resizewin, +0, +50"
      "super+alt, left, resizewin, -50, +0"
      "super+alt, right, resizewin, +50, +0"
    ]

    [
      # Keybinded Programs
      "super, return, spawn, ${getExe kitty}"
      "super, space, spawn, ${getExe noctalia} ipc call launcher toggle"

      # Media keys
      "none, XF86AudioRaiseVolume, spawn, ${getExe noctalia} ipc call volume increase"
      "none, XF86AudioLowerVolume, spawn, ${getExe noctalia} ipc call volume decrease"
      "none, XF86AudioMute, spawn, ${getExe noctalia} ipc call volume muteOutput"
      "none, XF86MonBrightnessUp, spawn, ${getExe noctalia} ipc call brightness increase"
      "none, XF86MonBrightnessDown, spawn, ${getExe noctalia} ipc call brightness decrease"

      # Screenshots
      "super, s, spawn_shell, ${getExe grim} - | tee $GRIM_DEFAULT_DIR/$(date +%y-%m-%d-%H:%M:%S).png | ${wl-clipboard}/bin/wl-copy"
    ]
  ];

  axisbind = [
    # Super + scroll moves up/down tags
    "super, up, viewtoleft_have_client"
    "super, down, viewtoright_have_client"
  ];

  gesturebind = [
    # 3-Finger swipe to change workspaces on trackpad
    "none, up, 3, viewtoleft_have_client"
    "none, down, 3, viewtoright_have_client"
  ];

  mousebind = [
    # Move around and resize windows with super + mouse
    "super, btn_left, moveresize, curmove"
    "super, btn_right, moveresize, curresize"
  ];

  # === Keyboard Settings ===
  repeat_rate = 25;
  repeat_delay = 600;
  numlockon = 0;
  xkb_rules_layout = "us";

  # === Trackpad Settings ===
  disable_trackpad = 0;
  tap_to_click = 1;
  tap_and_drag = 1;
  drag_lock = 1;
  trackpad_natural_scrolling = 0;
  disable_while_typing = 1;
  left_handed = 0;
  middle_button_emulation = 0;
  swipe_min_threshold = 1;

  # === Layouts ===
  tagrule = concatLists [
    # Set all layouts to use tgmix by default
    (forTag1to9 (tag: "id:${tag}, layout_name:tgmix"))
  ];

  # Overview 'Layout'
  hotarea_size = 10;
  enable_hotarea = 1;
  ov_tab_mode = 0;
  overviewgappi = 5;
  overviewgappo = 30;

  # Scroller Layout
  scroller_structs = 20;
  scroller_default_proportion = 0.8;
  scroller_focus_center = 0;
  scroller_prefer_center = 0;
  edge_scroller_pointer_focus = 1;
  scroller_default_proportion_single = 1.0;
  scroller_proportion_preset = "0.5, 0.8, 1.0";

  # Master Layout
  new_is_master = 0;
  default_mfact = 0.55;
  default_nmaster = 1;
  smartgaps = 0;

  # === Monitor settings ===
  monitorrule = [
    # Monitor for my desktop PC
    "model:^24E4$, width:1920, height:1080, refresh:120, vrr:1, scale:1"
    # Laptop monitor
    "name:^eDP-1$, width:2560, height:1600, refresh:60, scale:2"
  ];

  # === Blur & Shadows ===
  blur = 1;
  shadows = 0;

  # === Window Visuals ===
  borderpx = 4;
  border_radius = 8;
  no_radius_when_single = 0;
  focused_opacity = 1.0;
  unfocused_opacity = 0.96;

  # Window Separation
  gappih = 4;
  gappiv = 4;
  gappoh = 8;
  gappov = 8;

  # === Animations ===
  animations = 1;

  # Animation for switching tags
  tag_animation_direction = 0;
  animation_duration_tag = 300;
  animation_curve_tag = "0.46, 1.0, 0.29, 1";

  # Animation for opening windows
  animation_type_open = "zoom";
  zoom_initial_ratio = 0.2;
  animation_duration_open = 400;
  animation_curve_open = "0.46, 1.0, 0.29, 1";

  # Animation for closing windows
  animation_type_close = "fade";
  fadeout_begin_opacity = 1.0;
  animation_duration_close = 200;
  animation_curve_close = "0.46, 1.0, 0.29, 1";

  # === Misc ===
  no_border_when_single = 0;
  axis_bind_apply_timeout = 100;
  focus_on_activate = 1;
  idleinhibit_ignore_visible = 0;
  sloppyfocus = 1;
  warpcursor = 1;
  focus_cross_monitor = 0;
  focus_cross_tag = 0;
  enable_floating_snap = 0;
  snap_distance = 30;
  drag_tile_to_tile = 1;
  source_optional = "~/.cache/matugen/mango.conf";

  # === Environment ===
  env = let
    home = "/home/pengo";
  in [
    "XDG_CONFIG_HOME,${home}/.config"
    "XDG_CACHE_HOME,${home}/.cache"
    "XDG_DATA_HOME,${home}/.local/share"
    "XDG_DESKTOP_DIR,${home}/Desktop"
    "XDG_DOCUMENTS_DIR,${home}/Documents"
    "XDG_DOWNLOAD_DIR,${home}/Downloads"
    "XDG_MUSIC_DIR,${home}/Music"
    "XDG_PICTURES_DIR,${home}/Pictures"
    "XDG_VIDEOS_DIR,${home}/Videos"
    "GRIM_DEFAULT_DIR,${home}/Pictures/Screenshots"
  ];
}
