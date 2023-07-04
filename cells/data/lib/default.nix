{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
in {
  toJSON = file:
    nixpkgs.runCommand "toJSON.json" {preferLocalBuild = true;} ''
      ${nixpkgs.remarshal}/bin/yaml2json -i ${file} -o $out
    '';
}
