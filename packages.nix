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
      i3lock
      i3status
      iftop
      iputils
      lsof
      mercurial
      mosh
      pandoc
      psmisc
      python
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
      xclip
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
