{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs self;
  inherit (inputs.cells._writers.library) writeShellApplication;
  inherit (cell.library) makeSopsEnv makes makeScript __output__;
in {
  secrets-for-gpg-from-env = makeSopsEnv __output__.secretsForEnvFromSops.example;
  a = makeScript {
    name = "a";
    __output__ = __output__.envVars.example;
    searchPaths.bin = [nixpkgs.hello];
    text = "hello --help echo $a";
  };
  doc = let
    nickelDoc = makes ./doc-makeSubstitution.nix { inherit __output__; };
    in
      writeShellApplication {
    name = "doc";
    runtimeInputs = [ self.packages.makeConfiguration-nickel ];
    text = ''
    nickel query -f ${nickelDoc}/template "$@"
    '';
  };
}
