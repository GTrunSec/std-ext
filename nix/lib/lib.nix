{
  inputs,
  cell,
}: let
  l = inputs.nixpkgs.lib // builtins;
in {
  path = import ./lib/path.nix {inherit inputs cell;};

  digga = import ./lib/digga.nix {inherit inputs cell;};

  importers = import ./lib/importers.nix {inherit inputs cell;};

  types = import ./lib/types.nix {inherit inputs cell;};

  list = import ./lib/list.nix {inherit inputs cell;};

  attrsets = import ./lib/attrsets.nix {inherit l;};

  files = import ./lib/files.nix {inherit inputs cell;};
}
