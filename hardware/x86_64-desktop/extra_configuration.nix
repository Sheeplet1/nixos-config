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
}
