{
  inputs,
  cell,
}: let
  inherit (inputs.cells.main.library) __inputs__;
  inherit (__inputs__) nixpkgs-hardenedlinux;

  nixpkgs = inputs.nixpkgs.appendOverlays [
    (import ./nomad.nix)
  ];
  terraform-providers-bin = __inputs__.terraform-providers.legacyPackages.providers;
in {
  terraform = nixpkgs.terraform.withPlugins (p: [
    terraform-providers-bin.hashicorp.nomad
    terraform-providers-bin.dmacvicar.libvirt
    terraform-providers-bin.hashicorp.aws
    terraform-providers-bin.hashicorp.template
  ]);

  inherit
    (nixpkgs-hardenedlinux.packages)
    vault-cli
    ;
  inherit
    (nixpkgs)
    nomad
    ;
}
