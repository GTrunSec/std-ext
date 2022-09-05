{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-lock.follows = "nixpkgs";
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
      cellsFrom = ./nix;
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];
      cellBlocks = [
        (std.blockTypes.installables "packages")

        (std.blockTypes.nixago "nixago")

        (std.blockTypes.functions "devshellProfiles")
        (std.blockTypes.devshells "devshells")

        (std.blockTypes.runnables "entrypoints")
        (std.blockTypes.runnables "onPremises")

        (std.blockTypes.functions "generators")
        (std.blockTypes.functions "library")

        (std.blockTypes.functions "nixosProfiles")
        (std.blockTypes.microvms "microvmProfiles")

        (std.blockTypes.files "configFiles")
        (std.blockTypes.data "containerJobs")
        (std.blockTypes.data "schemaProfiles")

        (std.blockTypes.data "consulProfiles")
        (std.blockTypes.data "nomadJobs")
        (std.blockTypes.data "terranix")

        (std.blockTypes.data "cargoMakeJobs")
        (std.blockTypes.data "waterwheelJobs")
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
