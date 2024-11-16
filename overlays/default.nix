{
  inputs,
  pkgs,
  ...
}:
{
  nixpkgs.overlays = [
    inputs.alacritty-theme.overlays.default
    inputs.rust-overlay.overlays.default
  ];

  environment.systemPackages = [ pkgs.rust-bin.stable.latest.default ];
}
