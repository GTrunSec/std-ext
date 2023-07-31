{ inputs, cell }:
let
  inherit (inputs) nixpkgs;
in
{
  default = _: {
    imports = [ ];
    commands = [
      {
        package = nixpkgs.sops;
        category = "secrets";
      }
      {
        package = nixpkgs.age;
        category = "secrets";
      }
    ];
  };
}
