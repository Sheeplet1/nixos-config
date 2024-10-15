{ inputs, config, pkgs, ... }:
{
  imports = [
    ../../modules/vmware-guest.nix
  ];

  # Enable aarm64 to use x86_64 packages since they most will still work.
  boot.binfmt.emulatedSystems = ["x86_64-linux"];

  # VMWare only supports this as "0", otherwise you will see "error switching
  # console mode" on boot
  boot.loader.systemd-boot.consoleMode = "0";

  # TODO: Trying to sync clipboard between host and guest - to move this into 
  # separate config file
  disabledModules = [ "virtualisation/vmware-guest.nix" ];
  virtualisation.vmware.guest.enable = true;

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
