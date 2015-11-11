{ config, lib, pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ./common.nix
  ];

  networking = {
    hostName = "kit";
    wireless = {
      enable = true;
    };
  };

  boot = {
    kernelModules = [ ];
    extraModulePackages = [ ];

    initrd = {
      availableKernelModules = [
        "uhci_hcd"
        "ehci_pci"
        "ahci"
        "usb_storage"
      ];
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
    };

    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "ext2";
    };
  };

  swapDevices = [
    { device = "/dev/disk/by-label/swap"; }
  ];

  nix = {
    maxJobs = 2;
  };
}
