{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      bash
      bc
      chromium
      curl
      dmenu
      dropbox
      dropbox-cli
      firefoxWrapper
      fish
      gitAndTools.gitFull
      htop
      i3lock
      i3status
      iftop
      iputils
      lsof
      mercurial
      mosh
      networkmanagerapplet
      networkmanager_openvpn
      psmisc
      python
      ranger
      redshift
      rxvt_unicode
      silver-searcher
      tmux
      vimHugeX
      volumeicon
      wget
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
