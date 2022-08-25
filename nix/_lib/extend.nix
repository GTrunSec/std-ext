{inputs}: _lfinal: lprev: let
  lib = lprev;
in rec {
  mapNestedMattr = let
    f = x:
      lib.foldr
      (n: acc: acc // lib.mapAttrs' (n': lib.nameValuePair (n + "-" + n')) (x.${n})) {} (lib.attrNames x);
  in
    f;

  genAttrs' = values: f: lib.listToAttrs (map f values);

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
