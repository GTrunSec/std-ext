{l}: let
  inherit
    (l)
    nameValuePair
    genAttrs
    hasAttr
    ;
in rec {
  genAttrs' = values: f: l.listToAttrs (map f values);

  # counts the number of attributes in a set
  attrCount = set: l.length (l.attrNames set);

  defaultAttrs = attrs: default: f:
    if attrs != null
    then f attrs
    else default;

  # given a list of attribute sets, merges the keys specified by "names" from "defaults" into them if they do not exist
  defaultSetAttrs = sets: names: defaults: (l.mapAttrs' (n: v:
    nameValuePair n (
      v
      // genAttrs names (name: (
        if hasAttr name v
        then v.${name}
        else defaults.${name}
      ))
    ))
  sets);

  stripAttrsForHydra = filterAttrsOnlyRecursive (n: _: n != "recurseForDerivations" && n != "dimension");

  filterDerivations = filterAttrsOnlyRecursive (n: attrs: l.isDerivation attrs || attrs.recurseForDerivations or false);

  filterAttrsOnlyRecursive = pred: set:
    l.listToAttrs (
      l.concatMap
      (
        name: let
          v = set.${name};
        in
          if pred name v
          then [
            (l.nameValuePair name (
              if l.isAttrs v && !l.isDerivation v
              then filterAttrsOnlyRecursive pred v
              else v
            ))
          ]
          else []
      )
      (l.attrNames set)
    );

  # getAttrsByValue :: anything -> attrset -> attrset
  #
  # Get attrset items who have $value.

  getAttrsByValue = valueToFind: attrset:
    assert l.isAttrs attrset;
      l.filterAttrs (_: value: value == valueToFind) attrset;

  # Recursively merges attribute sets **and** lists
  recursiveMerge = attrList: let
    f = attrPath:
      l.zipAttrsWith (
        n: values:
          if l.tail values == []
          then l.head values
          else if l.all l.isList values
          then l.unique (l.concatLists values)
          else if l.all l.isAttrs values
          then f [n] values
          else l.last values
      );
  in
    f [] attrList;

  recursiveMergeAttrsWithNames = names: f: sets:
    l.zipAttrsWithNames names (name: vs: l.foldl' f {} vs) sets;

  recursiveMergeAttrsWith = f: sets:
    recursiveMergeAttrsWithNames (l.concatMap l.attrNames sets) f sets;

  # https://github.com/nix-community/disko/commit/309618f10a216035bff8293dacd721c5593d02db#diff-63b2750ca88f0bb1b20a657859ddd5df357da7d87777bfd4054db88de1a6a598R33
  /*
    deepMergeMap takes a function and a list of attrsets and deep merges them
  deepMergeMap :: -> (AttrSet -> AttrSet ) -> [ AttrSet ] -> Attrset
  Example:
    deepMergeMap (x: x.t = "test") [ { x = { y = 1; z = 3; }; } { x = { bla = 234; }; } ]
    => { x = { y = 1; z = 3; bla = 234; t = "test"; }; }
  */
  deepMergeMap = f: listOfAttrs:
    l.foldr (attr: acc: (l.recursiveUpdate acc (f attr))) {} listOfAttrs;
}
