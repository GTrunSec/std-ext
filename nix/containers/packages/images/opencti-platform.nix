{
  pkgs,
  nix2container,
}: let
  opencti-platform = nix2container.pullImage {
    imageName = "opencti/platform";
    imageDigest = "sha256:6dc70661be0c973052e6e7685c8b6a2c93e457c42b680442d5315048f01d9f80";
    sha256 = "sha256-QcyAk66+Y7fdqXCuy4kRBZf8WiLGcMckAaojjmsatu0=";
  };
in
  nix2container.buildImage {
    name = builtins.baseNameOf ./opencti-platform.nix;
    copyToRoot = [
      (pkgs.symlinkJoin {
        name = "root";
        paths = [pkgs.bashInteractive pkgs.coreutils];
      })
    ];
    fromImage = opencti-platform;
    config = {
      Cmd = ["/bin/bash"];
      #entrypoint = ["${pkgs.coreutils}/bin/ls" "-l" "/etc/alpine-release"];
    };
  }
