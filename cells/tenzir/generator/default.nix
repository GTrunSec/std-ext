{
  inputs,
  cell,
}: let
  inherit (inputs) data-merge;
  inherit (cell) configFiles;
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
in {
  vast.prod = prod;

  # mkSocProfile-custom-1 = library.makeConfiguration {
  #   searchPaths.path = [
  #     inputs.cells.openCTI.generator.nomad.vast
  #     inputs.cells.zeek.generator.nomad.vast
  #   ];
  # };
}
