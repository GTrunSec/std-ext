{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (cell) generator;
in {
  nomad-vast = nixpkgs.lib.recursiveUpdate inputs.lambda-microvm-hunting-lab.nixosConfigurations.nomad-tenzir-vast {
    config.services.vast = {
      enable = true;
      settings = generator.prod;
      extraConfigFile = null;
    };
  };
}
