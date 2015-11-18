{ config, pkgs, ... }:

{
  imports = [
    ./packages.nix
  ];

  boot = {
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

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  time = {
    timeZone = "America/New_York";
  };

  environment = {
    shells = [
      "${pkgs.bash}/bin/bash"
      "${pkgs.fish}/bin/fish"
    ];
    variables = {
      EDITOR = "vim";
    };
  };

  services = {
    xserver = {
      enable = true;
      layout = "us";

      displayManager = {
        sessionCommands = ''
          ${pkgs.rxvt_unicode}/bin/urxvtd -q -o -f &
          ${pkgs.unclutter}/bin/unclutter -idle 1 &
          ${pkgs.redshift}/bin/redshift &
        '';
        slim = {
          enable = true;
          autoLogin = true;
          defaultUser = "fox";
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

    polipo = {
      # Enable Polipo, a simple caching web proxy.
      # This helps speed up browsers, especially w3m which doesn't cache.
      enable = true;
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
        isNormalUser = true;
        extraGroups = [
          "wheel"
          "networkmanager"
        ];
        uid = 1000;
      };
    };
  };

  fonts = {
    fontconfig = {
      defaultFonts = {
        monospace = [
          "Sauce Code Powerline"
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
      corefonts # Microsoft free fonts
      powerline-fonts
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
