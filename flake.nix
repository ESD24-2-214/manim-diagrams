{
  description = "Flake to create manim pictures";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            # LaTeX
            texlive.combined.scheme-full

            # PDF reader
            okular

            # Make
            gnumake
            ffmpeg_6
            inotify-tools

            # Code Presentaion with Minted
            (pkgs.python313.withPackages (python-pkgs:
              with python-pkgs;
              [
                # select Python packages here
                manim
              ]))
          ];

          # to get the time correct
          SOURCE_DATE_EPOCH = self.sourceInfo.lastModified;
          shellHook = "";
        };

      });
}

# https://docs.platformio.org/en/latest/integration/ide/emacs.html
