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
        package = nixpkgs.docker-compose;
        category = "container";
      }
      {
        package = nixpkgs.podman-compose;
        category = "container";
      }
    ];
  };
}
