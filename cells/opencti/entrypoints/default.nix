{
  inputs,
  cell,
} @ args: let
  inherit (inputs) nixpkgs;
in {
  nomad-container-dev = (import ./nomad-container.nix args).dev;

  nomad-hydration-dev = (import ./nomad-container.nix args).hydration.dev;

  nomad-nixos-dev = (import ./docker-compose-prod.nix args).dev;

  docker-compose-prod = (import ./docker-compose-prod.nix args).prod;
}
