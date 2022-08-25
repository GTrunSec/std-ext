{
  pkgs,
  nix2container,
  inputs,
  cell,
}: let
  inherit (inputs.cells) cliche;
in
  nix2container.buildImage {
    name = builtins.baseNameOf ./images/cliche-example.nix;
    contents = [
      # When we want tools in /, we need to symlink them in order to
      # still have libraries in /nix/store. This differs from
      # dockerTools.buildImage but this allows to avoid habing files
      # both in / and /nix/store.
      (pkgs.symlinkJoin {
        name = "root";
        paths = [cliche.entrypoints.example];
      })
    ];
    config = {
      Cmd = ["/bin/example"];
    };
  }
