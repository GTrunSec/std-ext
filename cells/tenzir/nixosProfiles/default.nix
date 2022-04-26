{
  inputs,
  cell,
}: let
  inherit (cell) generator;
in {
  nomad.vast = {
    prod = inputs.lambda-microvm-hunting-lab.nixosConfigurations.nomad-tenzir-vast.extendModules {
      modules = [
        ./nomad-vast.nix
        {
          _module.args = {
            inherit generator;
          };
        }
      ];
    };

    dev = inputs.lambda-microvm-hunting-lab.nixosConfigurations.nomad-tenzir-vast.extendModules {
      modules = [
        ./nomad-vast.nix
        {
          _module.args = {
            inherit generator;
          };
        }
      ];
    };
  };
}
