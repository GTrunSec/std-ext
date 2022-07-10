{
  inputs,
  cell,
}: let
  inherit (inputs.cells.main.library) __inputs__;

  makes = inputs.std."x86_64-linux".std.lib.fromMakesWith __inputs__;

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
