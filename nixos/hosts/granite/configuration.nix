{
  imports = [
    ./hardware.nix
    ./users.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "granite";

  networking.networkmanager.enable = true;

  time.timeZone = "America/Denver";

  services.openssh.enable = true;
  services.openssh.settings = {
    PasswordAuthentication = false;
    PermitRootLogin = "no";
  };

  virtualisation.docker.enable = true;

  system.stateVersion = "25.11";
}
