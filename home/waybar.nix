{ pkgs, ... }:
{
    enable = true;
    settings = {
        mainBar = {
            layer = "top";
            position = "top";
            height = 30;

            modules-left = [ "hyprland/workspaces" ];
            modules-center = [ "clock" ];
            modules-right = [ "battery" ];

            clock = {
                format = "{:%H:%M}";
            };

            battery = {
                format = "{capacity} {icon}";
            };
        };
    };
}
