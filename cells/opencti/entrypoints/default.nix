{
  inputs,
  cell,
} @ args: let
  inherit (inputs) nixpkgs;
in {
  nomad-container-dev = (import ./nomad-container args).dev;

  nomad-hydration-dev = (import ./nomad-container args).hydration.dev;

  nomad-nixos-dev = (import ./nomad-nixos args).dev;

  docker-compose-prod = (import ./docker-compose args).prod;
}
