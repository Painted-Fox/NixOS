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
      psmisc
      python
      ranger
      redshift
      rxvt_unicode
      silver-searcher
      tmux
      unclutter
      vimHugeX
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
