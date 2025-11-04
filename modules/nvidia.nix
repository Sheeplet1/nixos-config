{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    nvidia.enable = lib.mkEnableOption "enables nvidia settings";
  };

  config = lib.mkIf config.nvidia.enable {
    environment.sessionVariables = {
      # Hyprland + Nvidia stuff
      GDK_BACKEND = "wayland,x11";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      LIBVA_DRIVER_NAME = "nvidia"; # hardware acceleration

      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_QPA_PLATFORMTHEME = "qt6ct";
      QT_SCALE_FACTOR = "1";
      QT_WAYLAND_DISABLE_WINDOWDECORATIONS = "1";

      CLUTTER_BACKEND = "wayland";
      GBM_BACKEND = "nvidia-drm";
      # NVD_BACKEND = "direct"

      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
    };

    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia = {
      modesetting.enable = true;
      open = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    hardware.graphics = {
      extraPackages = with pkgs; [
        libva-vdpau-driver
        libvdpau
        libvdpau-va-gl
        nvidia-vaapi-driver
        vdpauinfo
        libva
        libva-utils
      ];
    };

  };
}
