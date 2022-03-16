{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs self data-merge;
  inherit (cell) nomadJobs generator;
  inherit (inputs.cells._writers.library) writeShellApplication;
  inherit (inputs.cells._templates.library) attrConvertTemplate;
  inherit (inputs.cells.makes.library) __output__ makeSubstitution;
in {
  vast-nomad-default = attrConvertTemplate {
    source = nomadJobs.default;
    format = "yaml";
  };
  vast-config-prod = attrConvertTemplate {
    source = generator.prod;
    format = "yaml";
  };
}
