# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  environment.pathsToLink = [ "/libexec" ];

  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    OBSIDIAN_USE_WAYLAND = "1";
    XDG_CURRENT_DESKTOP = "sway";
    SDL_VIDEODRIVER= "wayland";
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "m9eid"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "America/New_York";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s20f0u4u2u1.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  services.fprintd.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.windowManager.xmonad = {
    enable = false;
    enableContribAndExtras = true;
  };
  services.xserver.windowManager.i3 = {
    enable = true;
    extraPackages = with pkgs; [
      dmenu
      i3status
      i3lock
    ];
  };

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.emilyb = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    git
    just
    bat
    neovim
    wget
    firefox-wayland
    vscode
    obsidian
    noweb
    borgbackup
    ripgrep
    entr
    alacritty
    texlive.combined.scheme-full
    clang
    clang-tools
    valgrind
    qemu_full
    killall
    any-nix-shell
    nix-doc
    nix-index
    tldr
    nitrogen
    dmenu
    exa
    roboto
    fira-code
    noto-fonts
    tamsyn
    gcc
    abuild
    ghc
    cabal-install
    python
    zotero
    jetbrains.clion
    jetbrains.idea-ultimate
    gh 
    github-desktop
    ninja
    rustup
    calibre
    vlc
    _1password
    alloy
    z3
    tlaplus
    coq
    idris2
    anki
    dolphin-emu
    mgba
    graphviz
    jupyter
    inkscape
    gimp
    blender
    go
    hugo
    SDL2
    emscripten
    ffmpeg
    poetry
    tree
    polybar
    wayland
    xwayland
    i3
  ];

  programs = {
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      extraPackages = with pkgs; [
        swaylock
        swayidle
        wl-clipboard
        mako
        wofi
      ];
    };
    # git = {
    #   enable = true;
    #   userEmail = "emily.a.bellows@hey.com";
    #   userName = "Emily Bellows";
    # };
    # broot = {
    #   enable = true;
    #   enableFishIntegration = true;
    # };
    # ssh = {
    #   enable = true;
    # };
    # fzf = {
    #   enable = true;
    #   enableFishIntegration = true;
    # };
    htop = {
      enable = true;
      settings = {
        sort_direction = true;
        sort_key = "PERCENT_CPU";
      };
    };
    # alacritty = {
    #   enable = true;
    #   settings = {
    #     shell.program= "${pkgs.fish}/bin/fish";
    #     window = {
    #       decorations = "full";
    #       padding = {
    #         x = 5;
    #         y = 5;
    #       };
    #     };
    #   };
    # };
    fish = {
      enable = true;
      shellAliases = {
        cat = "bat";
        ls = "exa";
        ll = "ls -a";
        tree = "exa -T";
        gs = "git status";
      };
    };
    # rofi = {
    #   enable = true;
    #   terminal = "${pkgs.alacritty}/bin/alacritty";
    # };
  };

  services.picom = {
    enable = false;
    activeOpacity = 1.0;
    inactiveOpacity = 0.9;
    backend = "glx";
    fade = true;
    fadeDelta = 5;
    shadow = true;
    shadowOpacity = 0.8;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}

