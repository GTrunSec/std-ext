{ inputs, cell }:
let
  inherit (inputs) nixpkgs;
  inherit (cell.lib) makeSopsScript makeScript __output__;
in
{
  secrets-for-gpg-from-env = makeSopsScript {
    name = "name";
    env = __output__.secretsForEnvFromSops.example;
    entrypoint = "echo $OPENCTI_ADMIN_EMAIL";
    searchPaths.bin = [ ];
  };
  scriptEnv = makeScript {
    name = "scriptEnv";
    env = {
      a = "1";
      b = "2";
      VAR_NAME = "test";
    };
    searchPaths.bin = [ nixpkgs.hello ];
    searchPaths.source = [ ];
    entrypoint = "hello --help echo $a";
  };
}
