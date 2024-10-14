{ pkgs, ... }:
{
	enable = true;
	settings = {
		env.TERM = "xterm-256color";
		# Hack for VM
		env.LIBGL_ALWAYS_SOFTWARE = "1";
		font = {
			# size = 12;
			# draw_bold_text_with_bright_colors = true;
		};
		selection.save_to_clipboard = true;
	};
}
