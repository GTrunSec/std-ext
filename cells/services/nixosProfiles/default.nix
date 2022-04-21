{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (cell) generator;
in {
  nomad-waterwheel-dev = inputs.lambda-microvm-hunting-lab.nixosConfigurations.nomad-waterwheel.extendModules {
    modules = [
      ./waterwheel-dev.nix
    ];
  };

  nomad-waterwheel-prod = inputs.lambda-microvm-hunting-lab.nixosConfigurations.nomad-waterwheel.extendModules {
    modules = [
      ./waterwheel-prod.nix
    ];
  };
}
