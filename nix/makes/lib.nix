{
  inputs,
  cell,
}: let
  inherit (inputs.cells.main.lib) __inputs__;

  makes = __inputs__.std."x86_64-linux".lib.dev.mkMakes;

  makeScript = args: makes ./makeLib/makeScript.nix {} args;

  makeSubstitution = args: makes ./makeLib/makeSubstitution.nix {} args;

  makeSopsScript = args: makes ./makeLib/secrets-for-gpg-from-env.nix {} args;

  __output__ = import ./makes.nix {inherit inputs;};
in {
  inherit
    __output__
    makes
    makeScript
    makeSopsScript
    makeSubstitution
    ;
}
