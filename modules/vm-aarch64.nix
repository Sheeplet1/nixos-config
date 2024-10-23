{ pkgs, lib, config, ... }:
{
  # Setup qemu so we can run x86_64 binaries
  boot.binfmt.emulatedSystems = ["x86_64-linux"];

  # open-vm-tools host and guest clipboard sync only works 
  # with X11 at the moment.
  # https://github.com/vmware/open-vm-tools/issues/660 
  virtualisation.vmware.guest.enable = true;
  environment.systemPackages = with pkgs; [ 
    # gtkmm3
    xsel
    xclip
  ];

  # Interface is this on M1
  networking.interfaces.ens160.useDHCP = true;

  # Lots of stuff that uses aarch64 that claims doesn't work, but actually works.
  nixpkgs.config.allowUnsupportedSystem = true;

  services = {
    xserver = {
      dpi = 254; # DPI for M1 14" Pro
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;
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
