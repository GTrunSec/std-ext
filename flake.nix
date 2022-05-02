{
  inputs = {
    std.url = "github:divnix/std";
    std.inputs.nixpkgs.follows = "nixpkgs";

    data-merge.url = "github:divnix/data-merge";
    data-merge.inputs.nixpkgs.follows = "nixpkgs";

    yants.url = "github:divnix/yants";
    yants.inputs.nixpkgs.follows = "nixpkgs";

    flake-compat.url = "github:edolstra/flake-compat";
    flake-compat.flake = false;

    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    latest.url = "github:NixOS/nixpkgs/master";

    nvfetcher.url = "github:berberman/nvfetcher";
    nvfetcher.inputs.nixpkgs.follows = "nixpkgs";

    nixpkgs-hardenedlinux.url = "github:hardenedlinux/nixpkgs-hardenedlinux";
    nixpkgs-hardenedlinux.inputs.nixpkgs.follows = "nixpkgs";

    dream2nix.url = "github:nix-community/dream2nix";

    makes.url = "github:fluidattacks/makes";
    makes.inputs.nixpkgs.follows = "nixpkgs";

    nickel.url = "github:tweag/nickel";
    nickel.inputs.nixpkgs.follows = "nixpkgs";
    nickel-nix.url = "github:nickel-lang/nickel-nix";
    nickel-nix.inputs.nixpkgs.follows = "nixpkgs";
    nickel-nix.inputs.nickel.follows = "nickel";

    terraform-providers.url = "github:numtide/nixpkgs-terraform-providers-bin";
    terraform-providers.inputs.nixpkgs.follows = "nixpkgs";
    terranix.url = "github:terranix/terranix";
    terranix.inputs.nixpkgs.follows = "nixpkgs";

    nomad-driver-nix.url = "github:input-output-hk/nomad-driver-nix";
    nomad-driver-nix.inputs.nixpkgs.follows = "nixpkgs";

    spongix.url = "github:input-output-hk/spongix";
    spongix.inputs.nixpkgs.follows = "nixpkgs";

    nix2container.url = "github:nlewo/nix2container";
    # nix2container.inputs.nixpkgs.follows = "nixpkgs"; # skopeo-nix2container override was locked by patch
  };

  # nix linters
  inputs = {
    deadnix.url = "github:astro/deadnix";
    statix.url = "github:nerdypepper/statix";
    statix.inputs.nixpkgs.follows = "nixpkgs";
  };

  inputs = {
    lambda-microvm-lab.url = "github:GTrunSec/lambda-microvm-lab";
    # lambda-microvm-lab.url = "/home/gtrun/ghq/github.com/GTrunSec/lambda-microvm-lab";
    lambda-microvm-lab.inputs.zeek2nix.follows = "zeek2nix";
    lambda-microvm-lab.inputs.vast2nix.follows = "vast2nix";

    vast2nix.url = "github:gtrunsec/vast2nix";
    zeek2nix.url = "github:hardenedlinux/zeek2nix";
    threatbus2nix.url = "github:gtrunsec/threatbus2nix";
  };
  outputs = {std, ...} @ inputs:
    std.grow {
      inherit inputs;
      #as-nix-cli-epiphyte = false;
      cellsFrom = ./cells;
      # debug = ["tenzir"];
      organelles = [
        (std.installables "packages")

        (std.runnables "entrypoints")
        (std.runnables "onPremises")

        (std.functions "generators")
        (std.functions "library")

        (std.functions "configFiles")

        (std.functions "nixosProfiles")
        (std.functions "devshellProfiles")

        (std.functions "containerJobs")

        # hashicorp ecoSystem
        (std.functions "consulProfiles")
        (std.functions "nomadJobs")
        (std.runnables "terranix")

        (std.functions "schemaProfiles")

        # Jobs workflow
        (std.functions "cargoMakeJobs")
        (std.functions "waterwheelJobs")
      ];
    };
}
