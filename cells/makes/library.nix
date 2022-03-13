{
  inputs,
  cell,
}: let
  makes = inputs.std."x86_64-linux".std.lib.fromMakesWith inputs;
  makeScript = {
    __output__,
    name ? "makeScript",
    text,
    searchPaths ? {},
  }:
    makes ./makeLib/makeScript.nix {} {inherit __output__ text name searchPaths;};
  makeEnvVars = __output__: makes ./makeLib/makeEnvVars.nix {inherit __output__;};
  makeSopsEnv = env: makes ./makeLib/secrets-for-gpg-from-env.nix {inherit env;};
  __output__ = import ./makes.nix {};
in {
  inherit
    __output__
    makes
    makeEnvVars
    makeScript
    makeSopsEnv
    ;
}
