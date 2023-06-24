{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    org-roam-book-template.url = "github:gtrunsec/org-roam-book-template";
    org-roam-book-template.inputs.nixpkgs.follows = "nixpkgs";
  };

  # Std Inputs
  inputs = {
    std.url = "github:divnix/std";
    std.inputs.nixpkgs.follows = "nixpkgs";
    std.inputs.devshell.follows = "devshell";
    std.inputs.nixago.follows = "nixago";
    # std.url = "/home/gtrun/guangtao/github.com/divnix/std";
    # std.url = "github:divnix/std/?ref=refs/pull/150/head";
    devshell.url = "github:numtide/devshell";
    nixago.url = "github:nix-community/nixago";
    nixago.inputs.nixpkgs.follows = "nixpkgs";
    flops.url = "github:gtrunsec/flops";
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
        (runnables "scripts")
        (runnables "onPremises")

        (functions "generators")
        (functions "lib")
        (functions "nu") # nushell scripts
        (functions "configs")
        (functions "overlays")

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
      ];
    } {
      devShells = inputs.std.harvest inputs.self ["automation" "devshells"];
      lib =
        (inputs.std.harvest inputs.self [
          ["workflows" "lib"]
          ["library" "lib"]
        ])
        .x86_64-linux;
      # process-compose =
      #   self.lib.mkProcessComposeTasks ["entrypoints" "onPremises"]
      #   self {
      #     log_location = "$HOME/.cache/process-compose.log";
      #   };
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
