{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (inputs.cells._writers.library) writeShellApplication;
  inherit (cell.library) makeSopsEnv makeEnvVars makeScript __output__ makes;
in {
  secrets-for-gpg-from-env = makeSopsEnv __output__.secretsForEnvFromSops.example;
  a = makeScript {
    name = "a";
    __output__ = __output__.envVars.example;
    searchPaths.bin = [ nixpkgs.hello ];
    text = "hello --help echo $a";
  };
}
