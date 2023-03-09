{
  inputs,
  cell,
}: let
  l = inputs.nixpkgs.lib // builtins;
in {
  # https://github.com/nix-community/disko/commit/309618f10a216035bff8293dacd721c5593d02db#diff-63b2750ca88f0bb1b20a657859ddd5df357da7d87777bfd4054db88de1a6a598R65
  /*
  A nix option type representing a json datastructure, vendored from nixpkgs to avoid dependency on pkgs
  */
  jsonType = with l.types; let
    valueType =
      nullOr
      (oneOf [
        bool
        int
        float
        str
        path
        (attrsOf valueType)
        (listOf valueType)
      ])
      // {
        description = "JSON value";
      };
  in
    valueType;
}
