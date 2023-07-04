{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
in {
  default = _: {
    imports = [];
    commands = [
      {
        package = nixpkgs.drone-cli;
        category = "Drone";
      }
      {
        package = nixpkgs.drone;
        category = "Drone";
      }
    ];
  };
}
