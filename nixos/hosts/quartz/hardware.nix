{ lib, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  hardware.asahi.peripheralFirmwareDirectory = ./firmware;

  boot.initrd.availableKernelModules = [ "usb_storage" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/1eadcaee-3a9f-42c4-a800-9590c71efe76";
      fsType = "btrfs";
      options = [ "subvol=@" "compress=zstd:1" ];
    };

    "/home" = {
      device = "/dev/disk/by-uuid/1eadcaee-3a9f-42c4-a800-9590c71efe76";
      fsType = "btrfs";
      options = [ "subvol=@home" "compress=zstd:1" ];
    };

    "/nix" = {
      device = "/dev/disk/by-uuid/1eadcaee-3a9f-42c4-a800-9590c71efe76";
      fsType = "btrfs";
      options = [ "subvol=@nix" "compress=zstd:5" ];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/1AC2-1E13";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };
  };

  swapDevices = [ ];
  zramSwap.enable = true;

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
