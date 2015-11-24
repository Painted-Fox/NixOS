# Vox is a VirtualBox machine.
#
# Encryption is handled by VirtualBox to simplify setup and configuration.
# It also removes the need to enter a password every reboot.  The virtual disk
# is setup in VirtualBox to show as a solid-state drive to the guest machine.
#
# Btrfs occupies the entire data storage device, replacing MBR or GPT.  During
# installation, the disk was setup via:
#
#   mkfs.btrfs -L nixos /dev/sda
#   mount -o noatime,discard,ssd,space_cache /dev/sda /mnt
#   nixos-generate-config --root /mnt
#
# Normally, the disadvantage to having Btrfs occupy the entire storage device
# is that it doesn't allow for partition encryption or swap space.  However,
# I use VirtualBox to encrypt the virtual disk, and I don't need swap space.
# If I run out of memory and run into errors, I can simply reboot and add more
# memory to the guest machine.
#
# Note that I did not enable compression during installation.  This can be run
# post install to apply compression to the installed files:
#
#   btrfs filesystem defragment -r -v clzo /

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
