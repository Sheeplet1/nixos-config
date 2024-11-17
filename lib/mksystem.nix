{ nixpkgs, overlays, inputs }:
name:
{
    system,
    user,
    nvidia ? false,
}:
let
  # machineConfig = if nvidia then ../machines/x86_64-nvidia/hardware-configuration.nix else ../machines/${name}/
in 
