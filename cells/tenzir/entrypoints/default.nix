{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs self;
  inherit (cell) nomadJobs configFiles;
  inherit (inputs.cells._writers.library) writeShellApplication;
  inherit (inputs.cells.makes.library) __output__ makeSubstitution;
in {
  vast-config = let
    nickelDoc = makeSubstitution {
      __output__ = __output__.documents.vast;
    };
  in
    writeShellApplication {
      name = "vast.yaml";
      runtimeInputs = [nixpkgs.remarshal];
      text = let
        json = nixpkgs.writeText "JSON" (builtins.toJSON configFiles.vast);
      in ''
        yaml2json  -i ${json} -o "$@"
      '';
    };
}
