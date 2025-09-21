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

    services.pulseaudio.enable = false;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    virtualisation.docker.enable = true;

    environment.systemPackages = with pkgs; [
      adwaita-icon-theme
      ags
      chromium
      discord
      docker
      eww
      firefox
      gtk3
      hyprcursor
      hypridle
      hyprland-qtutils
      hyprlock
      hyprpicker
      hyprshot
      hyprsunset
      inputs.zen-browser.packages."${pkgs.system}".default
      # jellyfin-media-player
      libnotify
      obsidian
      papirus-icon-theme
      playerctl
      pulseaudio
      qt5.qtwayland
      qt6.qtwayland
      spotify
      swappy # image viewer
      swww # wallpapers
      wl-clipboard
      wlogout
      wofi
      xdg-desktop-portal
      xdg-desktop-portal-gtk
      xdg-utils
      xwayland
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
