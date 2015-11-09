{ config, pkgs, ... }:

{
  imports = [
    ./packages.nix
  ];

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

    kernelModules = [ ];
    extraModulePackages = [ ];

    loader = {
      grub = {
        device = "/dev/sda";
        version = 2;
        memtest86 = {
          enable = true;
        };
      };
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

  networking = {
    hostName = "vox";
    networkmanager = {
      enable = true;
    };
  };

  nix = {
    maxJobs = 2;
  };

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  time = {
    timeZone = "America/New_York";
  };

  services = {
    xserver = {
      enable = true;
      layout = "us";

      displayManager = {
        lightdm = {
          enable = true;
        };
      };

      desktopManager = {
        xterm.enable = false;
        default = "none";
      };

      windowManager = {
        default = "i3";
        i3 = {
          enable = true;
        };
      };
    };
  };

  security = {
    sudo = {
      enable = true;
    };
  };

  users = {
    extraUsers = {
      fox = {
        description = "Fox";
        home = "/home/fox";
        extraGroups = [
          "wheel"
          "networkmanager"
        ];
        shell = "/run/current-system/sw/bin/fish";
        uid = 1000;
      };
    };
  };

  fonts = {
    fontconfig = {
      defaultFonts = {
        monospace = [
          "Source Code Pro"
        ];
        sansSerif = [
          "Source Sans Pro"
        ];
        serif = [
          "Source Serif Pro"
        ];
      };
    };
    fonts = with pkgs; [
      source-code-pro
      source-sans-pro
      source-serif-pro
    ];
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system = {
    stateVersion = "15.09";
  };
}
