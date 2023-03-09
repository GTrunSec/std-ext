{
  inputs,
  cell,
}: let
  l = inputs.nixpkgs.lib // builtins;
  inherit (l) filter;
in rec {
  # filters out empty strings and null objects from a list
  filterListNonEmpty = l: (filter (x: (x != "" && x != null)) l);

  imapAttrsToList = f: set: let
    keys = builtins.attrNames set;
    imap = key: f key (set.${key});
  in
    map imap keys;

  # maps attrs to list with an extra i iteration parameter
  imapAttrsToList' = f: set: (
    let
      keys = l.attrNames set;
    in
      l.genList (
        n: let
          key = l.elemAt keys n;
          value = set.${key};
        in
          f n key value
      ) (l.length keys)
  );
}
