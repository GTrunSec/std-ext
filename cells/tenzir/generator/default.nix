{ inputs, cell }:
let
  inherit (inputs) nixpkgs self data-merge;
  inherit (cell) nomadJobs configFiles library;
  inherit (inputs.cells._writers.library) writeShellApplication;
  inherit (inputs.cells.makes.library) __output__ makeSubstitution;
  # default
  vast-settings = {
    db-directory = "vast.db";
    file-verbosity = "debug";
  };
  # template
  prod = let
    vast.start = {
      print-endpoint = true;
    };
  in
    data-merge.merge (configFiles.vast (vast-settings // {file-verbosity = "info";})) {
                                                            vast.print-endpoint = true;
                                                          };

in
{
  vast-config-prod = library.vast-generator {
    target = prod;
  };
}
