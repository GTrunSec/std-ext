{
  inputs,
  cell,
} @ args: {
  nomad-node-prod = (import ./nomad-nixos args).prod;

  nomad-opencti-dev = (import ./nomad-nixos args).opencti.dev;

  config-vast-prod = (import ./vast-config args).prod;

  docker-compose-vast-prod = (import ./vast-container/compose.nix args).vast.prod;

  podman-vast-release-prod = (import ./vast-container/packages.nix args).release.prod;

  podman-vast-latest-prod = (import ./vast-container/packages.nix args).latest.prod;
}
