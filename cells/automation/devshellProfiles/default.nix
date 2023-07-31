{ inputs, cell }@args:
let
  inherit (inputs) nixpkgs;
in
rec {
  default = _: { imports = [ std ]; };

  std = import ./std.nix args;

  docs = ./docs.nix;
}
