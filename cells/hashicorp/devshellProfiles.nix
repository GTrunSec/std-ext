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
        package = packages.nomad;
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
