{ config, lib, pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ./common.nix
  ];

  networking = {
    hostId = "a794f064";
    hostName = "stout";
    enableIPv6 = false;
    interfaces = {
      enp2s0 = {
        ip4 = [{
          address = "192.168.0.42";
          prefixLength = 24;
        }];
      };
    };
    defaultGateway = "192.168.0.1";
    nameservers = [
      "8.8.8.8"
      "8.8.4.4"
    ];
  };

  services = {
    openssh = {
      enable = true;
      passwordAuthentication = false;
      permitRootLogin = "no";
      ports = [ 54321 ];
    };
  };

  boot = {
    kernelModules = [
      "kvm-intel"
    ];

    extraModulePackages = [ ];
    kernelPackages = pkgs.linuxPackages_4_2;

    initrd = {
      availableKernelModules = [
        "uhci_hcd"
        "ehci_pci"
        "ata_piix"
        "usb_storage"
        "floppy"
      ];

      luks = {
        devices = [{
          name = "nixos-root";
          device = "/dev/sda2";
          allowDiscards = true;
        }];
      };
    };

    zfs = {
      forceImportRoot = false;
      forceImportAll = false;
    };
  };

  fileSystems = {
    "/" = {
      device = "rpool/ROOT/nixos";
      fsType = "zfs";
    };

    "/home" = {
      device = "rpool/home";
      fsType = "zfs";
    };

    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "ext2";
    };
  };

  swapDevices = [
    { device = "/dev/zvol/rpool/swap"; }
  ];

  nix.maxJobs = 4;
}
