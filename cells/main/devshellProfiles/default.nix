{
  inputs,
  cell,
} @ args: let
  inherit (inputs) nixpkgs;
in rec {
  default = _: {imports = [std treefmt];};

  std = import ./std.nix args;

  treefmt = import ./treefmt.nix args;

  docs = import ./docs.nix;
}
