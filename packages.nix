{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      bash
      bc
      chromium
      curl
      dmenu
      dropbox-cli
      firefoxWrapper
      fish
      gitAndTools.gitFull
      htop
      httpie
      i3lock
      i3status
      iftop
      iputils
      libqalculate
      lsof
      mercurial
      mosh
      mpv
      pandoc
      psmisc
      python
      python34Packages.mps-youtube
      ranger
      redshift
      rxvt_unicode
      silver-searcher
      tmux
      unclutter
      vimHugeX
      w3m
      wget
      which
      xsel
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
