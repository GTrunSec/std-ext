{
  inputs,
  cell,
}: {
  src ? "",
  paths ? [],
  extraMd ? "",
  tip ? "",
}: let
  inherit (inputs) std self nixpkgs;
  inherit (inputs.cells.main.library) inputs';
  inherit (nixpkgs) lib;

  getDocs = path: (builtins.attrNames (inputs'.xnlib.lib.files.filterFilesBySuffix
    "${src}/${path}"
    "md"));

  dirs = map (p: p) [""] ++ (map (p: p + "/") paths);

  query = lib.flatten (map (p: (map (x: p + x) (getDocs p))) dirs);

  concatContent = s: f:
    lib.concatStringsSep s (map (f: let
        name = lib.removeSuffix ".md" f;
      in ''
        | ${name}   | display the `${f}` markdown file              |
      '')
      f);

  md' = concatContent "" query;

  md = nixpkgs.writeText "md" ''
    ${lib.optionalString (extraMd != "") "${lib.fileContents extraMd}"}
    ## Command Flags
    + Available flags:
    ${tip}
    | name      | description                           |
    |-----------|--------------------------------|
    |help| display the help markdown file|
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
  cell.library.writeShellApplication {
    name = "writeGlowDoc";
    runtimeInputs = [nixpkgs.glow];
    text = content;
  }
