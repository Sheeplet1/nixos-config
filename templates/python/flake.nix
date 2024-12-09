{
  description = "Nix-flake for Python development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-24.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachSystem
      [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ]
      (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          devShells.default = pkgs.mkShell {
            venvDir = ".venv";

            packages =
              with pkgs;
              [
                python312 # change version depending on requirements
                pyright
                ruff
                isort
              ]
              ++ (with pkgs.python312Packages; [
                pip
                venvShellHook
              ]);
          };
        }
      );
}
