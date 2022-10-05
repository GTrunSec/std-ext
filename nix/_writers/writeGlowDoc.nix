{
  inputs,
  cell,
}: {
  name ? "",
  src ? "",
  extraMd ? "",
  tip ? "",
}: let
  inherit (inputs) nixpkgs;
  inherit (inputs.cells.main.lib) __inputs__;
  inherit (nixpkgs) lib;

  getDocs = path: (builtins.attrNames (__inputs__.xnlib.lib.importers.filterFiles
    "/${path}"
    "md"));

  dirs = __inputs__.xnlib.lib.path.listAllDirs src;

  query = lib.flatten (map (p: (map (x:
      lib.removePrefix "/" ((lib.removePrefix src p) + "/" + x)) (getDocs p)))
  dirs);

  concatContent = s: f:
    lib.concatStringsSep s (map (f: let
        name = lib.removeSuffix ".md" f;
      in ''
        | ${name}   | display the `${lib.last (builtins.split "/" "${f}")}` doc              |
      '')
      f);

  md' = concatContent "" query;

  md = nixpkgs.writeText "md" ''
    ${lib.optionalString (extraMd != "") "${lib.fileContents extraMd}"}
    ## ${name}
    + Available flags:
    ${tip}
    | name      | description                           |
    |-----------|--------------------------------|
    |help| display the help menu|
    ${md'}
  '';

  flags = concatFlags " " query;

  concatFlags = s: f:
    lib.concatStringsSep s (map (f: let
        name = lib.removeSuffix ".md" f;
      in ''
        "${name}") glow ${src}/${f}
        ;;
      '')
      f);

  content = ''
    case "''${1}" in
    ${flags}
    "help") glow ${md}
    ;;
    *)
    esac
  '';
in
  cell.lib.writeShellApplication {
    name = "writeGlowDoc";
    runtimeInputs = [nixpkgs.glow];
    text = content;
  }
