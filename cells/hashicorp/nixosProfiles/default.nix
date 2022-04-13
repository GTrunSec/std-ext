{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (cell) generator;
in {
  cluster = nixpkgs.lib.recursiveUpdate inputs.lambda-microvm-hunting-lab.nixosConfigurations.nomad-qemu-cluster {};
}
