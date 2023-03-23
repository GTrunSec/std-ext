{
  inputs,
  cell,
}: let
  inherit (inputs.cells.common.lib) __inputs__;

  l = inputs.nixpkgs.lib.makeExtensible (self: let
    lib = inputs.nixpkgs.lib;
  in {
    path = import ./lib/path.nix {inherit inputs cell;};

    digga = import ./lib/digga.nix {inherit inputs cell;};

    importers = import ./lib/importers.nix {inherit inputs cell;};

    types = import ./lib/types.nix {inherit self lib;};

    list = import ./lib/list.nix {inherit inputs cell;};

    attrsets = import ./lib/attrsets.nix {inherit self lib;};

    files = import ./lib/files.nix {inherit self lib;};

    pop = __inputs__.pop.lib;
  });
in
  l
