{
  inputs,
  cell,
}: let
  inherit (inputs.cells.common.lib) __inputs__;

  l = inputs.nixpkgs.lib // builtins;

  makes = __inputs__.std."x86_64-linux".lib.dev.mkMakes;

  makeScript = makes ./makeLib/makeScript.nix {};

  makeSubstitution = makes ./makeLib/makeSubstitution.nix {};

  makeSopsScript = makes ./makeLib/secrets-for-gpg-from-env.nix {};

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
