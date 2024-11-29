{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{

  options = {
    desktop.enable = lib.mkEnableOption "enables desktop settings";
  };

  config = lib.mkIf config.desktop.enable {
    services.printing.enable = true;

    hardware.pulseaudio.enable = false;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    environment.systemPackages = with pkgs; [
      adwaita-icon-theme
      ags
      eww
      grim # screenshot functionality
      gtk3
      hyprcursor
      hypridle
      hyprlock
      hyprpicker
      hyprshot
      hyprsunset
      inputs.hyprpanel.packages."${pkgs.system}".default
      inputs.zen-browser.packages."${pkgs.system}".default
      libnotify
      obsidian
      papirus-icon-theme
      playerctl
      pulseaudio
      qt5.qtwayland
      qt6.qtwayland
      slurp # screenshot functionality
      spotify
      swappy # image viewer
      swww # wallpapers
      todoist-electron
      vesktop
      wlogout
      wofi
      xdg-desktop-portal
      xdg-desktop-portal-gtk
      xdg-utils
    ];

    programs = {
      thunar.enable = true;
      thunar.plugins = with pkgs.xfce; [
        exo
        mousepad
        thunar-archive-plugin
        thunar-volman
        tumbler
      ];
    };

    services = {
      # TODO: Need to figure out how to maximise resolution for tuigreet rather
      # than pseudo lockscreen with hyprlock.
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

    # Potentially needed to get hyprland working on nvidia? 
    # nixos.wiki/wiki/Hyprland
    # security.polkit.enable = true;
  };
}
