{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    latest.url = "github:NixOS/nixpkgs/master";
    nixos.url = "github:NixOS/nixpkgs/nixos-22.05";

    org-roam-book-template.url = "github:gtrunsec/org-roam-book-template";
    org-roam-book-template.inputs.nixpkgs.follows = "nixpkgs";
  };

  # Std Inputs
  inputs = {
    std.url = "github:divnix/std";
    std.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {std, ...} @ inputs: let
    clades = import ./clades inputs;
  in
    std.growOn {
      inherit inputs;
      cellsFrom = ./cells;
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];
      organelles = [
        (std.installables "packages")

        (std.nixago "nixago")

        (std.functions "devshellProfiles")
        (std.devshells "devshells")

        (std.runnables "entrypoints")
        (std.runnables "onPremises")

        (std.functions "generators")
        (std.functions "library")

        (std.functions "nixosProfiles")
        (std.microvms "microvmProfiles")

        (std.files "configFiles")
        (std.data "containerJobs")
        (std.data "schemaProfiles")

        (std.data "consulProfiles")
        (std.data "nomadJobs")
        (std.data "terranix")

        (std.data "cargoMakeJobs")
        (std.data "waterwheelJobs")
      ];
    } {
      devShells = inputs.std.harvest inputs.self ["main" "devshells"];
    } {
      templates = {
        default = {
          description = "The default template of Cells";
          path = ./templates/default;
        };
      };
    };
}
