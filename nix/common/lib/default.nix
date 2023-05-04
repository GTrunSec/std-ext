{
  inputs,
  cell,
} @ args: let
  inherit (inputs) nixpkgs std self;
  l = nixpkgs.lib // builtins;

  __inputs__ = cell.lib.callFlake ./lock {
    inherit (inputs) std;
  };
in {
  inherit __inputs__ inputs l std;

  mergeDevShell = import ./mergeDevShell.nix nixpkgs;

  callFlake = import ./callFlake.nix {inherit cell inputs;};
}
