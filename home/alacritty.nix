{ pkgs, ... }:
{
  enable = true;
  settings = {
    general = {
      import = [
        pkgs.alacritty-theme.kanagawa_wave
      ];

      live_config_reload = true;
    };

    env = {
      TERM = "xterm-256color";
      # Hack for VM
      LIBGL_ALWAYS_SOFTWARE = "1";
    };

    window = {
      dimensions = {
        columns = 160;
        lines = 80;
      };
      padding = {
        x = 4;
        y = 8;
      };
      decorations = "none";
      dynamic_title = true;
      title = "Alacritty";
    };

    cursor = {
      style = "Block";
    };

    terminal.shell = {
      program = "${pkgs.zsh}/bin/zsh";
    };

    font =
      let
        iosevka = style: {
          family = "Iosevka Nerd Font";
          inherit style;
        };
      in
      {
        normal = iosevka "Regular";
        bold = iosevka "Bold";
        italic = iosevka "Italic";
        bold_italic = iosevka "Bold Italic";
        size = 18;
      };

    selection.save_to_clipboard = true;

  };
}
