{ inputs, pkgs, ... }:

{
  imports = [
    inputs.apple-silicon.nixosModules.apple-silicon-support
    ./users.nix
    ./hardware.nix
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = false;
    };

    plymouth = {
      enable = true;
      theme = "cuts";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "cuts" ];
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

  age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

  networking.hostName = "quartz";

  networking.networkmanager.enable = true;

  time.timeZone = "America/Denver";

  services.flatpak.enable = true;
  services.displayManager.gdm.enable = true;

  system.stateVersion = "25.11";
}
