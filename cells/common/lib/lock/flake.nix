{
  # nix linters
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/7cc30fd5372ddafb3373c318507d9932bd74aafe";

    std.url = "github:divnix/std";
    std.inputs.n2c.follows = "n2c";
    std.inputs.nixpkgs.follows = "nixpkgs";
    std.inputs.microvm.follows = "microvm";
    std.inputs.makes.follows = "makes";

    std-data-collection.url = "github:divnix/std-data-collection";
    std-data-collection.inputs.std.follows = "std";
    std-data-collection.inputs.nixpkgs.follows = "nixpkgs";

    nuenv.url = "github:DeterminateSystems/nuenv";
    nuenv.inputs.nixpkgs.follows = "nixpkgs";
  };

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

  # utils
  inputs = {
    nvfetcher.url = "github:berberman/nvfetcher";
    nvfetcher.inputs.nixpkgs.follows = "nixpkgs";

    nixpkgs-hardenedlinux.url = "github:hardenedlinux/nixpkgs-hardenedlinux";
    nixpkgs-hardenedlinux.inputs.nixpkgs.follows = "nixpkgs";

    makes.url = "github:fluidattacks/makes";
    makes.inputs.nixpkgs.follows = "nixpkgs";

    n2c.url = "github:nlewo/nix2container";

    process-compose.url = "github:F1bonacc1/process-compose";
    process-compose.inputs.nixpkgs.follows = "nixpkgs";
  };

  # configuration modules
  inputs = {
    terraform-providers.url = "github:numtide/nixpkgs-terraform-providers-bin";
    terraform-providers.inputs.nixpkgs.follows = "nixpkgs";

    terranix.url = "github:terranix/terranix";
    terranix.inputs.nixpkgs.follows = "nixpkgs";

    julia2nix.url = "github:JuliaCN/julia2nix";
    julia2nix.inputs.nixpkgs.follows = "nixpkgs";

    poetry2nix.url = "github:nix-community/poetry2nix";
    poetry2nix.inputs.nixpkgs.follows = "nixpkgs";

    nix-std.url = "github:chessai/nix-std";
    pop.url = "github:divnix/POP";
    pop.inputs.nixpkgs.follows = "std/blank";
    pop.inputs.flake-compat.follows = "std/blank";
  };

  outputs = {self, ...} @ inputs: {
    inherit inputs;
  };
}
