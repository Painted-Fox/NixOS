{ config, pkgs, ... }:

{
  imports = [
    ./common.nix
  ];

  networking = {
    hostName = "vox";
  };

  virtualisation = {
    virtualbox = {
      guest = {
        enable = true;
      };
    };
  };

  boot = {
    initrd = {
      availableKernelModules = [
        "ata_piix"
        "ohci_pci"
      ];
    };
  };
}
