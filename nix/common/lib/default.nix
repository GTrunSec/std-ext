{
  inputs,
  cell,
} @ args: let
  inherit (inputs) nixpkgs std self;
  l = nixpkgs.lib // builtins;

  __inputs__ = cell.lib.callFlake "${(std.incl self ["lock"])}/lock" {
    # this is a hack to get the lock file to be followed in our nixpkgs channel
    nixpkgs.locked = inputs.nixpkgs.sourceInfo;
    std.locked = inputs.std.sourceInfo;
  };
in {
  inherit __inputs__ inputs l std;

  mergeDevShell = import ./mergeDevShell.nix nixpkgs;

  callFlake = import ./callFlake.nix args;
}
