{ inputs, cell }:
let
  inherit (inputs) nixpkgs;
  inherit (inputs.cells._writers.library) writeShellApplication;
  inherit (inputs.cells.makes.library) __output__ makeSubstitution;
in
{
  vast-generator = {
    target ? [ "prod" "develop" "template" ]
  }:
    writeShellApplication {
      name = "vast.yaml";
      runtimeInputs = [nixpkgs.remarshal];
      text = let
        json = nixpkgs.writeText "JSON" (builtins.toJSON target);
      in ''
        json2yaml  -i ${json} -o "$@"
      '';
    };
}
