{ inputs, cell }:
let
  inherit (inputs) nixpkgs;
  inherit (cell) packages;
in
{
  default = {
    env = [ {
      name = "VAULT_ADDR";
      value = "http://127.0.0.1:8200";
    } ];
    commands = [
      {
        package = packages.nomad;
        category = "hashicorp";
      }
      {
        package = nixpkgs.levant;
        category = "hashicorp";
      }
      {
        package = nixpkgs.consul;
        category = "hashicorp";
      }
      {
        package = nixpkgs.vault;
        category = "hashicorp";
      }
      {
        package = packages.vault-cli;
        category = "hashicorp";
      }
      {
        package = packages.terraform // {
          name = "terraform";
        };
        category = "hashicorp";
        help = "Terraform is an open-source infrastructure as code software tool that provides a consistent CLI workflow to manage hundreds of cloud services.";
      }
    ];
    packages =
      [
        # hashicorp.libvirtd required
        nixpkgs.cdrkit
      ];
  };
}
