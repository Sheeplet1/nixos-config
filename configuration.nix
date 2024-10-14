# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware/macos-vm/hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "anthony_nixos"; # Define your hostname.
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
  users.users.anthony = {
    isNormalUser = true;
    description = "Anthony";
    extraGroups = [ 
    	"networkmanager"
	"wheel" 
	"input"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [
    	stow
    ];
  };

  home-manager = {
	extraSpecialArgs = { inherit inputs; };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.nixPath = [ 
	"nixos-config=${config.users.users.anthony.home}/nix/configuration.nix"
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
	# foot
	alacritty
	clang
	curl
	eww
	gcc
	git
	go
	grim
	gtk3
	libnotify
	mako # notification daemon
	neovim	
	qt5.qtwayland
	qt6.qtwayland
	ripgrep
	rofi-wayland
	slurp
	swww
	tmux
  	tree
	waybar
	wget
	wl-clipboard
	xdg-desktop-portal
	xdg-desktop-portal-gtk
	xdg-utils
  ];

  environment.sessionVariables = {
  	WLR_NO_HARDWARE_CURSORS = "1";
	NIXOS_OZONE_WL = "1"; # Hint electron apps to use wayland
	MOZ_ENABLE_WAYLAND = "1";
	XDG_SESSION_TYPE = "wayland";
	XDG_CURRENT_DESKTOP = "Hyprland";
	XDG_SESSION_DESKTOP = "Hyprland";
	XDG_CONFIG_HOME = "$HOME/.config";
  };

  fonts.packages = with pkgs; [
	(nerdfonts.override { fonts = ["JetBrainsMono" "Iosevka" ]; })
  ];


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  hardware = {
	graphics = {
		enable = true;
	};
  };

  xdg = {
	autostart.enable = true;
	portal = {
		enable = true;
		extraPortals = [
			pkgs.xdg-desktop-portal
			pkgs.xdg-desktop-portal-gtk
		];
	};
  };

  programs = {
	ssh.startAgent= true;

	zsh = {
		enable = true;
	};

	hyprland = {
		enable = true;
		xwayland = {
			enable = true;
		};
	};
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services = {
	openssh.enable = true;

	displayManager.sddm.enable = true;

	xserver = {
		enable = true;
		xkb.layout = "au";
		desktopManager.plasma5.enable = true;
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
