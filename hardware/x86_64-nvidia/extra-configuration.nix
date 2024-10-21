{
  inputs,
  config,
  configs,
  pkgs,
  ...
}:
{
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    useOSProber = true;
    efiSupport = true;
  };

  # boot.kernelPackages = pkgs.linuxPackages_latest;

  services.printing.enable = true;

  # On desktop, the local DNS is flaky so we are prioritising Google
  # and Cloudflare first.
  networking = {
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

  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    # package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  hardware.graphics = {
    extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau
      libvdpau-va-gl
      nvidia-vaapi-driver
      vdpauinfo
      libva
      libva-utils
    ];
  };

  # Potentially needed to get hyprland working on nvidia? 
  # nixos.wiki/wiki/Hyprland
  # security.polkit.enable = true;

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    # If there is problems with Discord windows not displaying or screen sharing
    # not working in Zoom, comment out the below line.
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    # If there is crashes in firefox, comment out the below line.
    GBM_BACKEND = "nvidia-drm";
    NVD_BACKEND = "direct";
  };
}
