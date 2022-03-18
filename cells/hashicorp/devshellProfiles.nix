{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (cell) packages;
in {
  default = _: {
    imports = [];
    commands = [
      {
        package = nixpkgs.nomad;
        category = "hashicorp";
      }
      {
        package = nixpkgs.levant;
        category = "hashicorp";
      }
      {
        package = nixpkgs.vault;
        category = "hashicorp";
      }
      {
        package = packages.terraform;
        category = "hashicorp";
        help = "Terraform is an open-source infrastructure as code software tool that provides a consistent CLI workflow to manage hundreds of cloud services.";
      }
    ];
  };
}
