{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
in {
  # terraform = inputs.terraform-providers.legacyPackages.wrapTerraform nixpkgs.terraform (p: [
  #   p.hashicorp.nomad
  # ]);
  terraform = nixpkgs.terraform;
}
