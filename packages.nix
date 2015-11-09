{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      chromium
      dmenu
      dropbox
      dropbox-cli
      firefoxWrapper
      fish
      git
      i3lock
      i3status
      mercurial
      networkmanagerapplet
      networkmanager_openvpn
      python
      redshift
      rxvt_unicode
      tmux
      vimHugeX
      volumeicon
      which
    ];
  };

  nixpkgs = {
    config = {
      allowUnfree = true; # allow nix to install unfree licensed packages
      chromium = {
        enablePepperFlash = false;
      };
      firefox = {
        enableAdobeFlash = false;
      };
    };
  };
}
