{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    inputs.home-manager.nixosModules.default
  ];

  # Other devices using grub for bootloader
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    useOSProber = (if pkgs.system == "x86_64-linux" then true else false);
    efiSupport = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "dev"; # Define your hostname.

  # Enable networking
  networking = {
    networkmanager.enable = true;
    # The local DNS has been flaky lately so we are prioritising Google
    # and Cloudflare first.
    networkmanager.dns = "none";
    nameservers = [
      "8.8.8.8"
      "1.1.1.1"
    ];
    networkmanager.insertNameservers = [
      "8.8.8.8"
      "1.1.1.1"
    ];
  };

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
  };

  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

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
    nixPath = [
      "nixos-config=${config.users.users.anthonyd.home}/nix/configuration.nix"
      "nixpkgs=${inputs.nixpkgs}"
    ];
  };

  security.sudo.wheelNeedsPassword = false;

  environment.systemPackages = with pkgs; [
    alacritty
    cargo
    clang
    curl
    firefox
    fzf
    gcc
    git
    go
    jq
    lazygit
    neovim
    nixfmt-rfc-style
    nodejs
    python3
    ripgrep
    rustc
    stow
    tmux
    tree
    unzip
    wget
    zip
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Hint electron apps to use wayland
    XDG_CONFIG_HOME = "$HOME/.config";

    # Firefox
    MOZ_ENABLE_WAYLAND = "1";
  };

  fonts.packages = with pkgs; [
    atkinson-hyperlegible
    (nerdfonts.override {
      fonts = [
        "JetBrainsMono"
        "Iosevka"
      ];
    })
  ];

  programs = {
    ssh.startAgent = true;
    lazygit.enable = true;
    zsh.enable = true;
  };

  services = {
    openssh.enable = true;
    xserver = {
      enable = true;
      xkb.layout = "au";
    };
  };

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
      # xdg-desktop-portal 1.17 reworked how portal implementations are loaded, you
      # should either set `xdg.portal.config` or `xdg.portal.configPackages`
      # to specify which portal backend to use for the requested interface.
      # If you simply want to keep the behaviour in < 1.17, which uses the first
      # portal implementation found in lexicographical order, use the following:
      config.common.default = "*";
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
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
