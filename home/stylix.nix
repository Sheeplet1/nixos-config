{
  config,
  lib,
  pkgs,
  ...
}:
let
  colors = config.lib.stylix.colors;
  jetbrainsMono = {
    package = pkgs.nerd-fonts.jetbrains-mono;
    name = "JetBrainsMono Nerd Font";
  };
in
{
  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";

    fonts = {
      monospace = jetbrainsMono;
      sansSerif = jetbrainsMono;
      serif = jetbrainsMono;
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 12;
        popups = 12;
        terminal = 12;
      };
    };

    opacity.terminal = 0.95;
    targets.neovim.plugin = "mini.base16";
  };

  home.sessionVariables.STYLIX_ENABLED = "1";

  programs.fish = {
    shellInit = lib.mkAfter ''
      set -g theme_color_scheme base16-dark
    '';

    interactiveShellInit = lib.mkAfter ''
      function bobthefish_colors -S -d 'Apply the Stylix palette to Bobthefish'
        set -x color_initial_segment_exit ${colors.base05} ${colors.base08} --bold
        set -x color_initial_segment_private ${colors.base05} ${colors.base02}
        set -x color_initial_segment_su ${colors.base05} ${colors.base0B} --bold
        set -x color_initial_segment_jobs ${colors.base05} ${colors.base0D} --bold

        set -x color_path ${colors.base02} ${colors.base05}
        set -x color_path_basename ${colors.base02} ${colors.base06} --bold
        set -x color_path_nowrite ${colors.base02} ${colors.base08}
        set -x color_path_nowrite_basename ${colors.base02} ${colors.base08} --bold

        set -x color_repo ${colors.base0B} ${colors.base07}
        set -x color_repo_work_tree ${colors.base02} ${colors.base07} --bold
        set -x color_repo_dirty ${colors.base08} ${colors.base07}
        set -x color_repo_staged ${colors.base09} ${colors.base07}

        set -x color_vi_mode_default ${colors.base03} ${colors.base07} --bold
        set -x color_vi_mode_insert ${colors.base0B} ${colors.base07} --bold
        set -x color_vi_mode_visual ${colors.base09} ${colors.base07} --bold

        set -x color_vagrant ${colors.base0C} ${colors.base07} --bold
        set -x color_k8s ${colors.base0B} ${colors.base07} --bold
        set -x color_aws_vault ${colors.base0D} ${colors.base0A} --bold
        set -x color_aws_vault_expired ${colors.base0D} ${colors.base08} --bold
        set -x color_username ${colors.base02} ${colors.base0D} --bold
        set -x color_hostname ${colors.base02} ${colors.base0D}
        set -x color_rvm ${colors.base08} ${colors.base07} --bold
        set -x color_node ${colors.base0B} ${colors.base07} --bold
        set -x color_virtualfish ${colors.base0D} ${colors.base07} --bold
        set -x color_virtualgo ${colors.base0D} ${colors.base07} --bold
        set -x color_desk ${colors.base0D} ${colors.base07} --bold
        set -x color_nix ${colors.base0D} ${colors.base07} --bold

        set -gx color_jj_clean ${colors.base0E}
        set -gx color_jj_dirty ${colors.base08}
        set -gx color_jj_background ${colors.base00}
      end
    '';
  };
}
