{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs self;
  inherit (inputs.cells._writers.library) writeShellApplication;
  inherit (cell.library) makeSopsScript makeScript __output__ makeSubstitution;
in {
  secrets-for-gpg-from-env = makeSopsScript {
    name = "name";
    env = __output__.secretsForEnvFromSops.example;
    text = "echo $OPENCTI_ADMIN_EMAIL";
    searchPaths.bin = [];
  };
  scriptEnv = makeScript {
    name = "scriptEnv";
    env = __output__.envVars.example;
    searchPaths.bin = [nixpkgs.hello];
    searchPaths.source = [];
    text = "hello --help echo $a";
  };
}
