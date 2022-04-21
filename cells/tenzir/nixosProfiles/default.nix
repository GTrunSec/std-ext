{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (cell) generator;
in {
  nomad-vast = inputs.lambda-microvm-hunting-lab.nixosConfigurations.nomad-tenzir-vast.extendModules {
    modules = [
      ./nomad-vast.nix
      {
        _module.args = {
          inherit generator;
        };
      }
    ];
  };
}
