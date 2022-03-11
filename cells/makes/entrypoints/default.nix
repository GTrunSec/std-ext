{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (inputs.cells._writers.library) writeShellApplication;
  makes = inputs.std."x86_64-linux".std.lib.fromMakesWith inputs;
in {
  secrets-for-gpg-from-env = makes ./tests/secrets-for-gpg-from-env.nix {};
  shell = writeShellApplication {
    name = "shell";
    runtimeInputs = [];
    text = ''
    '';
  };
}
