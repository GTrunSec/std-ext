{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs nixpkgs-hardenedlinux;
in {
  # terraform = inputs.terraform-providers.legacyPackages.wrapTerraform nixpkgs.terraform (p: [
  #   p.hashicorp.nomad
  # ]);
  inherit
    (nixpkgs-hardenedlinux.packages)
    vault-cli
    ;
  terraform = nixpkgs.terraform;
}
