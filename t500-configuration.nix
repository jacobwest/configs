# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./t500-hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda";
    timeout = 5;
  };
  # boot.kernelPackages = pkgs.linuxPackages_latest;

  networking = {
    hostName = "quiddity";
    hostId = "42e62a35";
    networkmanager.enable = true;
    # enableIPv6 = false;
  };

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "lat9w-16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # List services that you want to enable:
  services = {
    dbus.enable = true;
    printing.enable = true;
    printing.drivers = [ pkgs.foomatic_filters ];
    openssh.enable = true;
    ntp.enable = true;
    locate.enable = true;
  };

  virtualisation.docker.enable = true;

  time.timeZone = "US/Pacific";

  system.autoUpgrade.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    exportConfiguration = true;
    layout = "us";
    # xkbOptions = "eurosign:e";

    synaptics.enable = true;
    synaptics.horizontalScroll = false;

    videoDriver = "intel";

    # slim is default
    # displayManager.slim.enable = true;
    # displayManager.slim.defaultUser = "jrw";
    # displayManager.slim.autoLogin = true;
    # displayManager.slim.theme = 
    # displayManager.lightdm.enable = true;
    # displayManager.kdm.enable = true;

    # displayManager.slim.theme = pkgs.fetchurl {
    #   url    = "https://github.com/jagajaga/nixos-slim-theme/archive/Final.tar.gz";
    #   sha256 = "4cab5987a7f1ad3cc463780d9f1ee3fbf43603105e6a6e538e4c2147bde3ee6b";
    # };

    windowManager = {
      xmonad.enable = true;
      xmonad.enableContribAndExtras = true;
      xmonad.extraPackages = haskellPackages: [
        haskellPackages.xmonad-screenshot
        haskellPackages.xmonad-utils	
        haskellPackages.xmonad-wallpaper
        haskellPackages.xmonad-windownames
      ];
      
      #compiz.enable = true;   # broken
      #metacity.enable = true; # broken
      #openbox.enable = true;
      default = "xmonad";
    };
    desktopManager = {
      xterm.enable = false;
      #gnome3.enable = true;
      #kde4.enable = true;
      default = "none";
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.extraUsers.guest = {
  #   isNormalUser = true;
  #   uid = 1000;
  # };

  environment.shells = [ "/run/current-system/sw/bin/zsh" ];
  programs.zsh.enable = true;
  users.defaultUserShell = "/run/current-system/sw/bin/zsh";

  fonts = {
    enableCoreFonts = true;
    enableFontDir = true;
    enableGhostscriptFonts = true;

    fonts = with pkgs; [
      corefonts
      dejavu_fonts
      hack-font
      terminus_font
      ubuntu_font_family
    ];
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    alsaLib
    alsaPlugins
    alsaUtils

    aspell
    aspellDicts.en

    bc
    conky
    dico
    docker
    dmenu
    dmenu2
    dzen2

    #emacs
    #emacs24-nox
    #emacs24Packages.gitModes
    #emacs24Packages.haskellMode
    #emacs24Packages.ocamlMode
    #emacs24Packages.org
    #emacs24Packages.prologMode
    #emacs24Packages.proofgeneral
    #emacs24Packages.structuredHaskellMode

    #evince
    #ffmpeg
    #firefoxWrapper
    #gcc
    #git
    #graphicsmagick

    #haskellPackages.Agda
    #haskellPackages.cabal2nix
    #haskellPackages.cabalInstall
    #haskellPackages.clay
    #haskellPackages.directSqlite
    #haskellPackages.haskelldb
    #haskellPackages.ghc
    #haskellPackages.hakyll
    #haskellPackages.HDBC
    #haskellPackages.mysql
    #haskellPackages.mysqlSimple
    #haskellPackages.persistentMysql
    #haskellPackages.persistentSqlite
    #haskellPackages.shelly
    #haskellPackages.snap    
    #haskellPackages.taffybar
    
    haskellPackages.xmobar
    haskellPackages.xmonad
    haskellPackages.xmonad-contrib
    haskellPackages.xmonad-extras
    haskellPackages.xmonad-screenshot
    haskellPackages.xmonad-utils
    haskellPackages.xmonad-wallpaper
    haskellPackages.xmonad-windownames

    #haskellPackages.yesod
    #haskellPackages.yi
    #haskellPackages.yiLanguage
    #haskellPackages.yiMonokai

    hicolor_icon_theme
    #lftp
    #libxml2
    #linuxPackages.virtualbox

    manpages
    mariadb
    #mysql55
    #mysql
    mysqlWorkbench

    #mercurial
    #mesa
    #mesa_glu
    #mosh
    #mpg123
    #mplayer

    #python27Full
    #python27Packages.pip
    #python27Packages.virtualenv

    #pygtk
    #python
    #pypy
    #pypyPackages.setuptools
    #pypyPackages.MySQL_python
    #pypyPackages.pysqlite

    rxvt_unicode

    slimThemes.flat
    slimThemes.flower2
    slimThemes.lake
    slimThemes.lunar
    slimThemes.mindlock
    slimThemes.nixosSlim
    slimThemes.wave
    slimThemes.zenwalk

    ## The tex system is poorly managed on NixOS.
    (pkgs.texLiveAggregationFun { paths = [ pkgs.texLive pkgs.texLiveExtra pkgs.texLiveBeamer pkgs.texLiveModerncv pkgs.texLivePGF pkgs.texLiveLatexXColor pkgs.texLiveCMSuper ]; })
#    texLive
#    texLiveBeamer
#    texLiveCMSuper
#    texLiveExtra
#    texLiveModerncv
#    texLiveLatexXColor
#    texLiveFull  # texLiveFull fails saying 2 dependencies could not be built.

    #scrot
    #smplayer
    #unzip
    #wget
    #wineUnstable
    #winetricks

    xlibs.libICE     # needed by Mathematica
    xlibs.libSM      # needed by Mathematica
    xlibs.libX11     # needed by Mathematica
    xlibs.libXcursor # needed by Mathematica
    xlibs.libXext    # needed by Mathematica
    xlibs.libXfixes  # needed by Mathematica
    xlibs.libXmu     # needed by Mathematica
    xlibs.libXrender # needed by Mathematica
    xlibs.libXrandr  # needed by Mathematica
    xlibs.xdpyinfo
    xscreensaver

    zsh
  ];

  nixpkgs.config = {
    allowUnfree = true;

    #chromium = {
    #  enablePepperFlash = true; # Adobe Flash no longer works
    #  # enablePepperPDF = true;
    #};
  };
}
