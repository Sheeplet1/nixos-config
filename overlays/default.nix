{
  inputs,
  pkgs,
  ...
}:
let
  hasRustOverlay = inputs ? rust-overlay;
in
{
  nixpkgs.overlays =
    [ ]
    ++ (if inputs ? alacritty-theme then [ inputs.alacritty-theme.overlays.default ] else [ ])
    ++ (if hasRustOverlay then [ inputs.rust-overlay.overlays.default ] else [ ]);

  environment.systemPackages =
    [ ] ++ (if hasRustOverlay then [ pkgs.rust-bin.stable.latest.default ] else [ ]);
}
