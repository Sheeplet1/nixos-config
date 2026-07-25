{ pkgs, ... }:

let
  port = 6969;

  excalidrawDesktop = pkgs.makeDesktopItem {
    name = "excalidraw";
    desktopName = "Excalidraw";
    genericName = "Diagram Editor";
    comment = "Create hand-drawn diagrams";

    exec = ''
      ${pkgs.chromium}/bin/chromium \
        --app=http://127.0.0.1:${toString port}
    '';

    icon = "applications-graphics";
    terminal = false;

    categories = [
      "Graphics"
      "Office"
    ];
  };
in
{
  virtualisation.docker.enable = true;

  virtualisation.oci-containers = {
    backend = "docker";

    containers.excalidraw = {
      image = "excalidraw/excalidraw:latest";
      autoStart = true;

      ports = [
        "127.0.0.1:${toString port}:80"
      ];
    };
  };

  environment.systemPackages = [
    excalidrawDesktop
  ];
}
