{
  inputs,
  cell,
}: let
  inherit (cell) packages;
in {
  cluster-dev = inputs.lambda-microvm-lab.nixosConfigurations.nomad-qemu-cluster.extendModules {
    modules = [
      ./nomad.nix
      {
        _module.args = {
          inherit packages;
        };
      }
    ];
  };
}
