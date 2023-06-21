{lib}: let
  inherit (lib) filter;
in rec {
  foldFunction = f: list: lib.foldl' lib.id f list;

  # filters out empty strings and null objects from a list
  filterListNonEmpty = l: (filter (x: (x != "" && x != null)) l);

  /*
  attrsToList' (key: v: l.toUpper v) {
    a = "x";
    b = "b";
    c = "a";
  };
  => [ "X" "B" "A" ]
  */

  attrsToList' = f: set: let
    keys = lib.attrNames set;
    imap = key: f key set.${key};
  in
    map imap keys;
  /*
   maps attrs to list with an extra i iteration parameter

  Type: imapAttrsToList :: (int -> a -> b) -> [a] -> [b]

   Example:
     imapAttrsToList (i: k: v: "${toString i} ${k} ${v}") { a = "x"; b = "b"; c = "a";};
     => [ "0a x" "1b b" "2c a" ]
  */
  imapAttrsToList = f: set: (
    let
      keys = lib.attrNames set;
    in
      lib.genList (
        n: let
          key = lib.elemAt keys n;
          value = set.${key};
        in
          f n key value
      ) (lib.length keys)
  );

  /*
    imapAttrsToList0 (i: k: v:  (k + v + (toString i))) {
       a = "x";
       b = "b";
       c = "a";
    };
  }
     => [ "ax0 1 2 3" "bb0 1 2 3" "ca0 1 2 3" ]
  */
  imapAttrsToList0 = f: set: let
    keys = builtins.attrNames set;
    values = builtins.attrValues set;
  in
    lib.zipListsWith (f (lib.range 0 (builtins.length keys))) keys values;
}
