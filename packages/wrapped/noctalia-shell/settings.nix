{nixpkgs, ...}: {
  bar.default = {
    position = "left";
    margin_edge = 8;
    margin_ends = 8;
    background_opacity = 0.75;

    start = [
      "launcher"
      "workspaces"
      "wallpaper"
    ];

    center = [
      "clock"
    ];

    end = [
      "tray"
      "cpu"
      "ram"
      "network"
      "bluetooth"
      "volume"
      "brightness"
      "battery"
      "session"
    ];
  };

  widget = {
    clock.format = "{:%m:%d:—:%H:%M}";
    network.show_label = false;
    workspaces.capsule = true;
  };

  weather = {
    enable = true;
    auto_locate = true;
  };

  wallpaper.directory = "/home/pengo/Pictures/Wallpapers";

  theme = {
    source = "wallpaper";

    templates = {
      enable_builtin_templates = true;
      builtin_ids = ["gtk4"];
      enable_community_templates = true;
      community_ids = ["discord"];
      enable_user_templates = true;
      user_config = nixpkgs.pkgs.writeText "templates.toml" (import ../matugen/templates);
    };
  };
}
