{ inputs, cell }:
let
  inherit (inputs.cells.common.lib) __inputs__;

  nixpkgs = inputs.nixpkgs.appendOverlays [
    (import ./nomad.nix)
    __inputs__.nixpkgs-hardenedlinux.pkgs.overlays.python
  ];
  terraform-providers-bin =
    __inputs__.terraform-providers.legacyPackages.providers;
in
{
  terraform = nixpkgs.terraform.withPlugins (
    p: [
      terraform-providers-bin.hashicorp.nomad
      terraform-providers-bin.dmacvicar.libvirt
      terraform-providers-bin.hashicorp.aws
      terraform-providers-bin.hashicorp.template
    ]
  );

  inherit (nixpkgs) nomad;

  inherit (nixpkgs.python3Packages) vault-cli;
}
