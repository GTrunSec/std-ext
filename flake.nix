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
    xnlib.url = "github:gtrunsec/xnlib";
    # xnlib.url = "/home/guangtao/ghq/github.com/GTrunSec/xnlib";
  };

  outputs = {
    std,
    self,
    ...
  } @ inputs: let
    clades = import ./clades inputs;
    systems = [
      "aarch64-darwin"
      "aarch64-linux"
      "x86_64-darwin"
      "x86_64-linux"
    ];
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
        (data "terranix")

        (data "cargoMakeJobs")
        (data "waterwheelJobs")
      ];
    } {
      devShells = inputs.std.harvest inputs.self ["automation" "devshells"];
      process-compose =
        (inputs.std.harvest inputs.self [["workflows" "lib" "mkProcessCompose"]]).x86_64-linux
        ["entrypoints" "onPremises"]
        self {
          log_location = "$HOME/.cache/process-compose.log";
        };
    } {
      templates = {
        default = {
          description = "The default template of Cells";
          path = ./templates/default;
        };
      };
    };
}
