{ pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ./impermanence.nix
    ./users.nix
  ];

  boot = {
    loader = {
      limine.enable = true;
      limine.efiSupport = true;

      efi.canTouchEfiVariables = true;
      timeout = 10;
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

  age.identityPaths = [ "/persist/etc/ssh/ssh_host_ed25519_key" ];

  services.displayManager.gdm.enable = true;

  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "pengo" ];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  environment.systemPackages = with pkgs; [
    swtpm
  ];

  programs.steam.enable = true;

  networking = {
    hostName = "amethyst";
    networkmanager.enable = true;
    networkmanager.insertNameservers = [ "192.168.1.148" ];
  };

  time.timeZone = "America/Denver";

  system.stateVersion = "25.11";
}
