{
  inputs,
  cell,
}: let
  inherit (cell) packages library;
  inherit (inputs) nixpkgs;
  inherit (inputs.cells._templates.library) nickelTemplate;
in {
  threatbus-nomad-nix = nickelTemplate {
    name = "threatbus";
    format = "json";
    file = ./tenzir/nomad/threatbus-nomad-nix.ncl;
  };
}
