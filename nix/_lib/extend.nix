{inputs}: _lfinal: lprev: let
  l = lprev // builtins;
in rec {
  mapNestedMattr = let
    f = x:
      l.foldr
      (n: acc: acc // l.mapAttrs' (n': l.nameValuePair (n + "-" + n')) (x.${n})) {} (l.attrNames x);
  in
    f;

  genAttrs' = values: f: l.listToAttrs (map f values);

  makeNestedJobs = paths: args:
    mapNestedMattr (mapNestedMattr (mapNestedMattr (genAttrs' paths (
      path: {
        name = baseNameOf path;
        value = import path args;
      }
    ))));

  pathsToImportedAttrs = paths: args:
    genAttrs' paths (
      path: {
        name = baseNameOf path;
        value = import path args;
      }
    );
}
