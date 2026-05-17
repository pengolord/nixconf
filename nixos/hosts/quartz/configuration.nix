{inputs, ...}: {
  imports = [
    inputs.apple-silicon.nixosModules.apple-silicon-support
    ./users.nix
    ./hardware.nix
  ];

  nix.apple-silicon.enable = true;

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = false;
  };

  boot.plymouthWithCuts.enable = true;

  programs.steam.enable = false;

  age.identityPaths = ["/etc/ssh/ssh_host_ed25519_key"];

  networking.hostName = "quartz";

  networking.networkmanager.enable = true;

  time.timeZone = "America/Denver";

  services.flatpak.enable = true;
  services.displayManager.gdm.enable = true;

  system.stateVersion = "25.11";
}
