{
  inputs = {
    std.url = "github:gtrunsec/std/self.packages";

    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    threatbus2nix.url = "github:gtrunsec/threatbus2nix";

    vast2nix.url = "github:gtrunsec/vast2nix";

    zeek2nix.url = "github:hardenedlinux/zeek2nix";

    nvfetcher.url = "github:berberman/nvfetcher";

    nixpkgs-hardenedlinux.url = "github:hardenedlinux/nixpkgs-hardenedlinux";

    dream2nix.url = "github:nix-community/dream2nix";

    makes.url = "github:fluidattacks/makes";
    makes.inputs.nixpkgs.follows = "nixpkgs";

    nickel.url = "github:tweag/nickel";
    nickel.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs:
    inputs.std.grow {
      inherit inputs;
      #as-nix-cli-epiphyte = false;
      cellsFrom = ./cells;
      systems = ["x86_64-linux" "x86_64-darwin"];
      organelles = [
        (inputs.std.installables "packages")
        (inputs.std.runnables "entrypoints")
        (inputs.std.functions "library")
        (inputs.std.functions "devshellProfiles")
      ];
    };
}
