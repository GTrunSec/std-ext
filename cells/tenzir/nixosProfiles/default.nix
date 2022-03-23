{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (cell) configFiles generator;
  nomad-nixos-1 = inputs.lambda-microvm-hunting-lab.nixosConfigurations.nomad-nixos-1;
in {
  nomad-nixos-1 = nixpkgs.lib.recursiveUpdate nomad-nixos-1 {
    config.services.vast = {
      enable = true;
      settings = generator.prod;
      extraConfigFile = null;
    };
  };
}
