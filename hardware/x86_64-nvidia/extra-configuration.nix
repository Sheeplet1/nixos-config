{ inputs, configs, pkgs, ... }:
{
    boot.loader.grub = {
       enable = true;
       device = "nodev";
       useOSProber = true;
       efiSupport = true;
    };

    services.printing.enable = true;

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
    };

    # Potentially needed to get hyprland working on nvidia? 
    # nixos.wiki/wiki/Hyprland
    # security.polkit.enable = true;
}
