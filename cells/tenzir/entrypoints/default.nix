{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs self data-merge;
  inherit (cell) nomadJobs configFiles;
  inherit (inputs.cells._writers.library) writeShellApplication;
  inherit (inputs.cells.makes.library) __output__ makeSubstitution;
  # default
  vast-settings = {
    # db-directory = "vast.db";
  };
  # template
  vast-yaml = configFiles.vast {
    db-directory = "vast.db";
  };
in {
  vast-config = let
    # state
    prod = let
      vast.start = {
        print-endpoint = true;
      };
    in data-merge.merge (configFiles.vast (vast-settings // { db-directory = "vast.db"; })) {
      vast.print-endpoint = true;
    };
  in
    writeShellApplication {
      name = "vast.yaml";
      runtimeInputs = [nixpkgs.remarshal];
      text = let
        json = nixpkgs.writeText "JSON" (builtins.toJSON prod);
      in ''
        json2yaml  -i ${json} -o "$@"
      '';
    };
}
