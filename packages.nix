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
      gnupg21     # GnuPG is a free implementation of the OpenPGP standard.
      htop
      httpie
      i3lock
      i3status
      iftop
      iputils
      isync       # IMAP and MailDir mailbox synchronizer.
      keepassx2   # KeePass Password manager.
      libqalculate
      lsof
      mercurial
      mosh
      mpv
      openvpn
      pandoc
      pass        # Password manager that follows Unix philosophy by zx2c4
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
