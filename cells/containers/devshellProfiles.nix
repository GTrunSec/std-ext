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
      {
        name = "podman-rmi";
        command = ''
          podman images -a | grep "$@" | awk '{print $3}' | xargs podman rmi --force
        '';
        category = "container";
        help = "delete images by pattern";
      }
      {
        name = "docker-rmi";
        command = ''
          docker images -a | grep "$@" | awk '{print $3}' | xargs docker rmi --force
        '';
        category = "container";
        help = "delete images by pattern";
      }
    ];
  };
}
