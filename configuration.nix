# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  inputs,
  config,
  unstable,
  pkgs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    inputs.home-manager.nixosModules.default
  ];

  # Other devices using grub for bootloader
  boot.loader.systemd-boot.enable = (if pkgs.system != "x86_64-linux" then true else false);
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "dev"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Australia/Sydney";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  users.defaultUserShell = pkgs.zsh;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.anthonyd = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "input"
      "docker"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      open-vm-tools
    ];
  };

  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true;

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    nixPath = [ "nixos-config=${config.users.users.anthonyd.home}/nix/configuration.nix" ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alacritty
    clang
    curl
    eww
    firefox
    fzf
    gcc
    git
    go
    grim # screenshot functionality
    gtk3
    hyprlock
    hyprcursor
    hypridle
    jq
    libnotify
    mako # notification daemon
    nixfmt-rfc-style
    obsidian
    qt5.qtwayland
    qt6.qtwayland
    ripgrep
    slurp # screenshot functionality
    spotify
    stow
    swww
    tmux
    tree
    neovim
    unzip
    vanilla-dmz
    vesktop
    waybar
    wget
    wl-clipboard
    wofi
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-utils
    zip
  ] ++ (if pkgs.system == "x86_64-linux" then  [ inputs.zen-browser.packages."${pkgs.system}".default ] else []); 

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Hint electron apps to use wayland

    # Firefox
    MOZ_ENABLE_WAYLAND = "1";

    XDG_CONFIG_HOME = "$HOME/.config";

    # Hyprland + Nvidia stuff
    # WLR_DRM_NO_ATOMIC = "1";
    GDK_BACKEND = "wayland,x11";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    LIBVA_DRIVER_NAME = "nvidia"; # hardware acceleration
    WLR_NO_HARDWARE_CURSORS = "1";

    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    # QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_QPA_PLATFORMTHEME = "qt6ct";
    QT_SCALE_FACTOR = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATIONS = "1";

    # __GL_VRR_ALLOWED = "1";

    # for VM and possibly Nvidia
    # WLR_RENDERER_ALLOW_SOFTWARE = "1"; 

    CLUTTER_BACKEND = "wayland";
    GBM_BACKEND = "nvidia-drm";
    # NVD_BACKEND = "direct"

    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
  };

  fonts.packages = with pkgs; [
    atkinson-hyperlegible
    (nerdfonts.override { fonts = [ "JetBrainsMono" "Iosevka" ]; })
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  hardware = {
    graphics.enable = true;
    logitech.wireless = {
      enable = true;
      enableGraphical = true;
    };
  };

  xdg = {
    autostart.enable = true;
    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
    };
  };

  programs = {
    ssh.startAgent = true;

    zsh = {
      enable = true;
    };

    hyprland = {
      enable = true;
      xwayland.enable = true;
      # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland; #hyprland-git
      # portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland; # xdphls
    };

    regreet = {
        enable = true;
        cageArgs = [ "last" ]; # Prevents greeter from spanning multiple monitors
    };

    waybar.enable = true;

    thunar.enable = true;
    thunar.plugins = with pkgs.xfce; [
      exo
      mousepad
      thunar-archive-plugin
      thunar-volman
      tumbler
    ];
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services = {
    openssh.enable = true;

    # gnome.gnome-keyring.enable = true;

    greetd = {
        enable = true;
        vt = 3; # use tty3 
        settings = {
            default_session = {
                user = "anthonyd";
                # Starting "Hyprland" with TUI login manager
                command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
            };
        };
    };

    xserver = {
      enable = true;
      xkb.layout = "au";
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
