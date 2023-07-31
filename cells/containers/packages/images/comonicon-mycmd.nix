{
  pkgs,
  nix2container,
  inputs,
  cell,
}:
let
  inherit (inputs.cells) comonicon;
  cmdVar = pkgs.runCommand "cmdVar" { } ''
    mkdir -p $out/tmp
  '';
in
nix2container.buildImage {
  name = builtins.baseNameOf ./images/comonicon-mycmd.nix;
  copyToRoot = [
    comonicon.entrypoints.mycmd
    cmdVar
    # When we want tools in /, we need to symlink them in order to
    # still have libraries in /nix/store. This differs from
    # dockerTools.buildImage but this allows to avoid habing files
    # both in / and /nix/store.
    (pkgs.symlinkJoin {
      name = "root";
      paths = [
        pkgs.bash
        pkgs.coreutils
      ];
    })
  ];
  config = {
    Cmd = [ "/bin/mycmd" ];
    Env = [ "CELL_ROOT=${../../..}" ];
  };
}
