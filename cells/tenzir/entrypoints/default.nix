{
  inputs,
  cell,
} @ args: {
  nomad-node-prod = (import ./nomad-nixos args).prod;

  nomad-opencti-dev = (import ./nomad-nixos args).opencti.dev;

  # socProfile-openCTI-solution = makeSocProfile {
  #   features = {
  #     # TIPs
  #     openCTI = true;
  #     zeek = true;
  #   };
  #   target = "nomad"; # or k8s, podman, docker;
  # };

  config-vast-prod = (import ./vast-config args).prod;
}
