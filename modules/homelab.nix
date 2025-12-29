{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    homelab.enable = lib.mkEnableOption "Enable packages for homelab management";
  };

  config = lib.mkIf config.homelab.enable {
    environment.systemPackages = with pkgs; [
      argocd
      helmfile
      k3s
      kubernetes-helm
      kubeseal
      qrencode
      wireguard-tools
    ];
  };
}
