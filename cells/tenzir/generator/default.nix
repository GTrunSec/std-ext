{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs self data-merge;
  inherit (cell) nomadJobs configFiles library;
  inherit (inputs.cells._writers.library) writeShellApplication;
  inherit (inputs.cells._templates.library) attrConvertTemplate;
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
in {
  inherit prod;
  mkSocProfile-custom-1 = library.makeConfiguration {
    searchPaths.path = [
      inputs.cells.openCTI.generator.k8s.vast
      inputs.cells.zeek.generator.k8s.vast
    ];
  };
  socProfile = {
    openCTI ? false,
    MISP ? false,
    zeek ? false,
    suricata ? false,
    branch ? ["prod" "develop" "CI"],
    target ? ["k8s" "nomad"],
  }:
    prod;
}
