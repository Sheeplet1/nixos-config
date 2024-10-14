{ pkgs, ... }:
{
    enable = true;
    settings = {
        "$mod" = "SUPER";
        # TODO: Add in zen-browser or firefox depending on machine
        bind = [
            "$mod, RETURN, exec, alacritty"
            "$mod, Q, killactive"
            "$mod, T, exec, thunar"
            "$mod, M, exit"
            "$mod, left, movefocus, l"
            "$mod, right, movefocus, r"
            "$mod, up, movefocus, u"
            "$mod, down, movefocus, d"
        ]
        ++ (
            builtins.concatLists (builtins.genList(i:
                    let ws = i + 1;
                    in [
                        "$mod, code:1${toString i}, workspace, ${toString ws}"
                        "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
                    ]
                )
            10)
        );
    };
}
