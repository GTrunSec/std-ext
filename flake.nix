{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    latest.url = "github:NixOS/nixpkgs/master";
    nixos.url = "github:NixOS/nixpkgs/nixos-22.05";

    std.url = "github:divnix/std";
    std.inputs.nixpkgs.follows = "nixpkgs";
    yants.follows = "std/yants";

    data-merge.url = "github:divnix/data-merge";
    data-merge.inputs.nixpkgs.follows = "nixpkgs";

    org-roam-book-template.url = "github:gtrunsec/org-roam-book-template";
    org-roam-book-template.inputs.nixpkgs.follows = "nixpkgs";
  };

  # utils
  inputs = {
    nvfetcher.url = "github:berberman/nvfetcher";
    nvfetcher.inputs.nixpkgs.follows = "nixpkgs";

    nixpkgs-hardenedlinux.url = "github:hardenedlinux/nixpkgs-hardenedlinux";
    nixpkgs-hardenedlinux.inputs.nixpkgs.follows = "nixpkgs";

    makes.url = "github:fluidattacks/makes";
    makes.inputs.nixpkgs.follows = "nixpkgs";

    nix2container.url = "github:nlewo/nix2container";
    # nix2container.inputs.nixpkgs.follows = "nixpkgs"; # skopeo-nix2container override was locked by patch
  };

  # nix linters
  inputs = {
    deadnix.url = "github:astro/deadnix";
    deadnix.inputs.nixpkgs.follows = "nixpkgs";

    statix.url = "github:nerdypepper/statix";
    statix.inputs.nixpkgs.follows = "nixpkgs";
  };

  inputs = {
    microvm.url = "github:astro/microvm.nix";
    nomad-driver.url = "github:input-output-hk/nomad-driver-nix";
    nomad-driver.inputs.nixpkgs.follows = "nixpkgs";
  };

  # configuration modules
  inputs = {
    nickel.url = "github:tweag/nickel";
    nickel.inputs.nixpkgs.follows = "nixpkgs";
    nickel-nix.url = "github:nickel-lang/nickel-nix";
    nickel-nix.inputs.nixpkgs.follows = "nixpkgs";
    nickel-nix.inputs.nickel.follows = "nickel";

    terraform-providers.url = "github:numtide/nixpkgs-terraform-providers-bin";
    terraform-providers.inputs.nixpkgs.follows = "nixpkgs";
    terranix.url = "github:terranix/terranix";
    terranix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {std, ...} @ inputs: let
    clades = import ./clades {inherit inputs;};
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
        (clades.installables "packages")

        (std.functions "devshellProfiles")
        (std.devshells "devshells")

        (std.runnables "entrypoints")
        (std.runnables "onPremises")

        (std.functions "generators")
        (std.functions "library")

        (std.functions "nixosProfiles")
        (clades.microvms "microvmProfiles")

        (std.data "configFiles")
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
      inherit (clades) installables files microvms;
    } {
      templates = {
        default = {
          description = "The default template of Cells";
          path = ./templates/default;
        };
      };
    };
}
