{
  inputs,
  cell,
}: let
  inherit (inputs.cells.main.library) __inputs__;
  inherit (__inputs__) nixpkgs-hardenedlinux;
  nixpkgs = inputs.nixpkgs.appendOverlays [
    (import ./nomad.nix)
  ];
in {
  # terraform = inputs.terraform-providers.legacyPackages.wrapTerraform nixpkgs.terraform (p: [
  #   p.hashicorp.nomad
  # ]);

  inherit
    (nixpkgs-hardenedlinux.packages)
    vault-cli
    ;
  inherit
    (nixpkgs)
    terraform
    nomad
    ;
}
