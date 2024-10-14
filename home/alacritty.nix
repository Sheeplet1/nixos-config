{ pkgs, ... }:
{
	enable = true;
	settings = {
        env = {
            TERM = "xterm-256color";
            # Hack for VM
            LIBGL_ALWAYS_SOFTWARE = "1";
        };

        window = {
            dimensions = { columns = 160; lines = 80; };
            padding = { x = 4; y = 8; };
            decorations = "full";
            dynamic_title = true;
            title = "Alacritty";
        };

        cursor = {
            style = "Block";
        };

        shell = {
            program = "${pkgs.zsh}/bin/zsh";
        };
        

        font = let iosevka = style: {
            family = "Iosevka Nerd Font";
            inherit style;
        }; in {
            normal = iosevka "Regular";
            bold = iosevka "Bold";
            italic = iosevka "Italic";
            bold_italic = iosevka "Bold Italic";
        };

		selection.save_to_clipboard = true;

        live_config_reload = true;
	};
}
