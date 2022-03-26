{
  inputs,
  cell,
}: let
  makes = inputs.std."x86_64-linux".std.lib.fromMakesWith inputs;

  makeScript = args: makes ./makeLib/makeScript.nix {} args;

  makeSubstitution = args: makes ./makeLib/makeSubstitution.nix {} args;

  makeSops = args: makes ./makeLib/secrets-for-gpg-from-env.nix {} args;

  __output__ = import ./makes.nix {inherit inputs;};
in {
  inherit
    __output__
    makes
    makeScript
    makeSops
    makeSubstitution
    ;
}
