{
  inputs,
  cell,
} @ args: let
  inherit (inputs) nixpkgs std self;
  l = nixpkgs.lib // builtins;

  __inputs__ = cell.lib.callFlake "${(std.incl self [(self + /lock)])}/lock" {
    # this is a hack to get the lock file to be followed in our nixpkgs channel
    nixpkgs.locked = inputs.nixpkgs-lock.sourceInfo;
    nixos.locked =
      inputs.nixos.sourceInfo
      // {
        type = "github";
        owner = "NixOS";
        repo = "nixpkgs";
      };
    statix.inputs.nixpkgs = "nixpkgs";
    nixpkgs-hardenedlinux.inputs.nixpkgs = "nixpkgs";
    nvfetcher.inputs.nixpkgs = "nixos";
    makes.inputs.nixpkgs = "nixpkgs";

    std.locked = inputs.std.sourceInfo;
    std.inputs.nixpkgs = "nixpkgs";
    std.inputs.microvm = "microvm";
    std.inputs.makes = "makes";
    std.inputs.n2c = "n2c";
  };
in {
  inherit __inputs__ inputs l std;

  mergeDevShell = import ./mergeDevShell.nix nixpkgs;

  callFlake = import ./callFlake.nix args;
}
