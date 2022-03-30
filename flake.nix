{
  inputs = {
    std.url = "github:divnix/std";
    data-merge.url = "github:divnix/data-merge";
    yants.url = "github:divnix/yants";

    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    latest.url = "github:NixOS/nixpkgs/master";

    lambda-microvm-hunting-lab.url = "github:GTrunSec/lambda-microvm-hunting-lab";
    lambda-microvm-hunting-lab.inputs.zeek2nix.follows = "zeek2nix";
    lambda-microvm-hunting-lab.inputs.vast2nix.follows = "vast2nix";

    threatbus2nix.url = "github:gtrunsec/threatbus2nix";

    vast2nix.url = "github:gtrunsec/vast2nix";

    zeek2nix.url = "github:hardenedlinux/zeek2nix";

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
    deadnix.url = "github:gtrunsec/deadnix/packages.name";
    statix.url = "github:nerdypepper/statix";
    statix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {std, ...} @ inputs:
    std.grow {
      inherit inputs;
      #as-nix-cli-epiphyte = false;
      cellsFrom = ./cells;
      # debug = ["tenzir"];
      systems = ["x86_64-linux" "x86_64-darwin"];
      organelles = [
        (std.installables "packages")
        (std.runnables "entrypoints")
        (std.functions "generators")
        (std.functions "library")
        (std.functions "nomadJobs")
        (std.functions "nixosProfiles")
        (std.functions "dockerJobs")
        (std.runnables "terranix")
        (std.functions "configFiles")
        (std.functions "devshellProfiles")
        (std.functions "consulProfiles")
      ];
    };
}
