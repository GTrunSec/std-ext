{
  # nix linters
  inputs = {
    deadnix.url = "github:astro/deadnix";
    statix.url = "github:nerdypepper/statix";
  };

  inputs = {
    microvm.url = "github:astro/microvm.nix";
    nomad-driver.url = "github:input-output-hk/nomad-driver-nix";
  };

  # utils
  inputs = {
    xnlib.url = "github:gtrunsec/xnlib";

    nvfetcher.url = "github:berberman/nvfetcher";

    nixpkgs-hardenedlinux.url = "github:hardenedlinux/nixpkgs-hardenedlinux";

    makes.url = "github:fluidattacks/makes";

    nix2container.url = "github:nlewo/nix2container";
    # nix2container.inputs.nixpkgs.follows = "nixpkgs"; # skopeo-nix2container override was locked by patch
  };

  # configuration modules
  inputs = {
    nickel.url = "github:tweag/nickel";
    nickel-nix.url = "github:nickel-lang/nickel-nix";
    nickel-nix.inputs.nickel.follows = "nickel";

    terraform-providers.url = "github:numtide/nixpkgs-terraform-providers-bin";
    terranix.url = "github:terranix/terranix";
  };

  outputs = {self, ...} @ inputs: {
    inherit inputs;
  };
}
