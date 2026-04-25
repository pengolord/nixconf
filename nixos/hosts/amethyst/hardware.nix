{ config, lib, modulesPath, pkgs, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  boot.initrd.luks.devices."crypted".device = "/dev/disk/by-uuid/c5a46ba7-0141-48bb-a09a-ed11b233073d";

  fileSystems = {
    "/" = {
      device = "none";
      fsType = "tmpfs";
      options = [ "defaults" "size=2G" "mode=755" ];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/B071-868E";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

    "/nix" = {
      device = "/dev/mapper/crypted";
      fsType = "btrfs";
      options = [ "subvol=@nix" "compress=zstd:5" ];
    };

    "/var" = {
      device = "/dev/mapper/crypted";
      fsType = "btrfs";
      options = [ "subvol=@var" "compress=zstd:1" ];
    };

    "/home" = {
      device = "/dev/mapper/crypted";
      fsType = "btrfs";
      neededForBoot = true;
      options = [ "subvol=@home" "compress=zstd:1" ];
    };

    "/persist" = {
      device = "/dev/mapper/crypted";
      fsType = "btrfs";
      neededForBoot = true;
      options = [ "subvol=@persist" "compress=zstd:1" ];
    };

    "/swap" = {
      device = "/dev/mapper/crypted";
      fsType = "btrfs";
      options = [ "subvol=swap" ];
    };
  };

  swapDevices = [{
    device = "/swap/swapfile";
    size = 32768;
  }];

  hardware.graphics.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
