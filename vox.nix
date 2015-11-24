{ config, lib, pkgs, ... }:

{
  imports = [
    ./common.nix
  ];

  networking = {
    hostId = "4b52f689";
    hostName = "vox";
  };

  virtualisation.virtualbox.guest.enable = true;

  services = {
    xserver = {
      displayManager = {
        sessionCommands = ''
          xrandr --output VGA-1 --auto --output VGA-0 --auto --right-of VGA-1
        '';
      };
    };
  };

  boot = {
    kernelModules = [ ];
    extraModulePackages = [ ];
    kernelPackages = pkgs.linuxPackages_4_2;

    initrd = {
      availableKernelModules = [
        "ata_piix"
        "ohci_pci"
        "ahci"
      ];
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = "noatime,discard,ssd,compress=lzo,space_cache";
    };

    # Caution: NixOS will crash on boot if there is no VirtualBox shared folder
    # with the device name here.
    "/vbox" = {
      fsType = "vboxsf";
      device = "share";
      options = "rw";
    };
  };

  nix = {
    maxJobs = 2;
  };
}
