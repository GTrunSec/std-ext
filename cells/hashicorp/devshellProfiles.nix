{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (cell) packages;
in {
  default = _: {
    imports = [];
    commands = [
      {
        package = nixpkgs.nomad;
        category = "hashicorp";
      }
      {
        package = nixpkgs.levant;
        category = "hashicorp";
      }
      {
        package = nixpkgs.vault;
        category = "hashicorp";
      }
    ];
  };
}
