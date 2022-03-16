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
    vast-yaml = {
      vast = configFiles.vast {
        db-directory = "vast.db";
      };
    };
  in
    writeShellApplication {
      name = "vast.yaml";
      runtimeInputs = [nixpkgs.remarshal];
      text = let
        json = nixpkgs.writeText "JSON" (builtins.toJSON vast-yaml);
      in ''
        json2yaml  -i ${json} -o "$@"
      '';
    };
}
