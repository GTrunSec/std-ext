{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (cell) generator packages;
in {
  cluster = inputs.lambda-microvm-hunting-lab.nixosConfigurations.nomad-qemu-cluster.extendModules {
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
