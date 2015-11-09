# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "vox"; # Define your hostname.

  # Enable using NetworkManager.
  networking.networkmanager.enable = true;

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable LightDM as the display manager.
  services.xserver.displayManager.lightdm.enable = true;

  # Enable the i3 tiling window manager.
  services.xserver.windowManager.i3.enable = true;

  # Use fish by default
  #users.defaultUserShell = "/run/current-system/sw/bin/fish";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.fox = {
    isNormalUser = true;
    home = "/home/fox";
    description = "Fox";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = "/run/current-system/sw/bin/fish";
    uid = 1000;
  };

  # Enable the Profile Sync daemon to sync browser profiles.
  services.psd.enable = true;
  services.psd.users = [ "fox" ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  # Packages to install
  environment.systemPackages = with pkgs; [
    vimHugeX
    git
    mercurial
    fish
    tmux
    which
    python
    dropbox
    dropbox-cli
    networkmanager_openvpn
    rxvt_unicode
    i3status
    i3lock
    dmenu
    networkmanagerapplet
    volumeicon
    redshift
    chromium
    firefox
  ];

  # System fonts
  fonts.fonts = with pkgs; [
    source-code-pro
  ];

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "15.09";

}
