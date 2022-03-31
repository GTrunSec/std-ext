{
  pkgs,
  nix2container,
  version,
}: {
  inputs,
  cell,
}: let
  inherit (cell) packages;
in
  nix2container.buildImage {
    name = builtins.baseNameOf ./.;
    contents = [
      # When we want tools in /, we need to symlink them in order to
      # still have libraries in /nix/store. This differs from
      # dockerTools.buildImage but this allows to avoid habing files
      # both in / and /nix/store.
      (pkgs.symlinkJoin {
        name = "root";
        paths = [packages."vast-${version}"];
      })
    ];
    config = {
      Cmd = ["/bin/vast"];
    };
  }
