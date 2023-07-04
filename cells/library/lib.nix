{
  inputs,
  cell,
}: let
  inherit (inputs.cells.common.lib) __inputs__;

  l = (inputs.nixpkgs.lib // builtins).makeExtensible (self: let
    lib = inputs.nixpkgs.lib // builtins // l;
  in {
    path = import ./lib/path.nix {inherit lib;};

    digga = import ./lib/digga.nix {inherit lib;};

    importers = import ./lib/importers.nix {inherit lib;};

    types = import ./lib/types.nix {inherit lib;};

    list = import ./lib/list.nix {inherit lib;};

    attrsets = import ./lib/attrsets.nix {inherit lib;};

    files = import ./lib/files.nix {inherit lib;};
  });
in
  l
