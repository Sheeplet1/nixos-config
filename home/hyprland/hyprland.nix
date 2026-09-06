{ ... }:
let
in
{
  enable = true;
  configType = "lua";
  extraConfig = builtins.readFile ./hyprland.lua;
}
