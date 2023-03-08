{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixos.url = "github:NixOS/nixpkgs/nixos-22.11";

    org-roam-book-template.url = "github:gtrunsec/org-roam-book-template";
    org-roam-book-template.inputs.nixpkgs.follows = "nixpkgs";
  };

  # Std Inputs
  inputs = {
    std.url = "github:divnix/std";
    # std.url = "/home/gtrun/ghq/github.com/divnix/std";
    # std.url = "github:divnix/std/?ref=refs/pull/150/head";
    std.inputs.nixpkgs.follows = "nixpkgs";

    std-data-collection.url = "github:divnix/std-data-collection";
    std-data-collection.inputs.std.follows = "std";
    std-data-collection.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    std,
    self,
    ...
  } @ inputs: let
    blockTypes = import ./blockTypes inputs;
  in
    std.growOn {
      inherit inputs;

      cellsFrom = ./nix;

      cellBlocks = with std.blockTypes; [
        (installables "packages")

        (nixago "nixago")

        (functions "devshellProfiles")
        (devshells "devshells")

        (runnables "entrypoints")
        (runnables "onPremises")

        (functions "generators")
        (functions "lib")
        (functions "config")

        (functions "nixosProfiles")
        (microvms "microvmProfiles")

        (files "configFiles")
        (data "containerJobs")
        (data "schemaProfiles")

        (data "consulProfiles")
        (data "nomadJobs")
        (data "composeJobs")
        (data "terranix")

        (data "cargoMakeJobs")
        (data "waterwheelJobs")

        (functions "utils")
        (functions "importers")
        (functions "attrsets")
        (functions "digga")
        (functions "validators")
        (functions "files")
        (functions "list")
        (functions "path")
        (functions "tests")
        (functions "types")
      ];
    } {
      devShells = inputs.std.harvest inputs.self ["automation" "devshells"];
      lib =
        (inputs.std.harvest inputs.self [
          ["workflows" "lib"]
          ["lib"]
        ])
        .x86_64-linux;

      process-compose =
        self.lib.mkProcessComposeTasks ["entrypoints" "onPremises"]
        self {
          log_location = "$HOME/.cache/process-compose.log";
        };
      inherit blockTypes;
    } {
      templates = {
        default = {
          description = "The default template of Cells";
          path = ./templates/default;
        };
      };
    };
}
