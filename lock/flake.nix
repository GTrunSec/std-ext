{
  # nix linters
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/14ccaaedd95a488dd7ae142757884d8e125b3363";

    std.url = "github:divnix/std";
    std.inputs.n2c.follows = "n2c";
    std.inputs.nixpkgs.follows = "nixpkgs";
    std.inputs.microvm.follows = "microvm";
    std.inputs.makes.follows = "makes";
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
    xnlib.url = "github:gtrunsec/xnlib";

    nvfetcher.url = "github:berberman/nvfetcher";
    nvfetcher.inputs.nixpkgs.follows = "nixpkgs";

    nixpkgs-hardenedlinux.url = "github:hardenedlinux/nixpkgs-hardenedlinux";
    nixpkgs-hardenedlinux.inputs.nixpkgs.follows = "nixpkgs";

    makes.url = "github:fluidattacks/makes";
    makes.inputs.nixpkgs.follows = "nixpkgs";

    n2c.url = "github:nlewo/nix2container";
  };

  # configuration modules
  inputs = {
    nickel.url = "github:tweag/nickel";
    nickel.inputs.nixpkgs.follows = "nixpkgs";
    nickel-nix.url = "github:nickel-lang/nickel-nix";
    nickel-nix.inputs.nickel.follows = "nickel";
    nickel-nix.inputs.nixpkgs.follows = "nixpkgs";

    terraform-providers.url = "github:numtide/nixpkgs-terraform-providers-bin";
    terraform-providers.inputs.nixpkgs.follows = "nixpkgs";

    terranix.url = "github:terranix/terranix";
    terrafix.url = "github:br4ch1st0chr0n3/terrafix";
    terrafix.inputs.nixpkgs.follows = "nixpkgs";

    julia2nix.url = "github:JuliaCN/julia2nix";
    julia2nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {self, ...} @ inputs: {
    inherit inputs;
  };
}
