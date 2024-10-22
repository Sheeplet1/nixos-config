{ pkgs, lib, config, ... }:
{
  # Setup qemu so we can run x86_64 binaries
  boot.binfmt.emulatedSystems = ["x86_64-linux"];

  virtualisation.vmware.guest.enable = true;
  environment.systemPackages = with pkgs; [ 
    gtkmm3
    open-vm-tools
  ];

  # Interface is this on M1
  networking.interfaces.ens160.useDHCP = true;

  # Lots of stuff that uses aarch64 that claims doesn't work, but actually works.
  nixpkgs.config.allowUnsupportedSystem = true;

  services = {
    xserver = {
      dpi = 254; # DPI for M1 14" Pro
      # desktopManager = {
      #   xterm.enable = false;
      #   wallpaper.mode = "fill";
      # };
      #
      # displayManager = {
      #   defaultSession = "none+i3";
      #   lightdm.enable = true;
      #
      #   sessionCommands = ''
      #     ${pkgs.xorg.xset}/bin/xset r rate 200 40
      #   '';
      # };

      greetd = {
        enable = true;
        vt = 3; # use tty3
        settings = {
          default_session = {
            user = "anthonyd";
            # Starting "Hyprland" with TUI login manager
            # command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
            command = "Hyprland";
          };
        };
      };
    };

  };
  # Share our host filesystem
  fileSystems."/host" = {
    fsType = "fuse./run/current-system/sw/bin/vmhgfs-fuse";
    device = ".host:/";
    options = [
      "umask=22"
        "uid=1000"
        "gid=1000"
        "allow_other"
        "auto_unmount"
        "defaults"
    ];
  };
}
