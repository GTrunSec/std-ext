{
  inputs,
  cell,
} @ args: let
  inherit (inputs) nixpkgs;
in {
  default = import ./main.nix args;
  docs = import ./docs.nix;
  mkshell = inputs.nixpkgs.mkShell {
    buildInputs = [nixpkgs.rustc];
  };
}
