{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs std;
  l = nixpkgs.lib // builtins;
in {
  /*
    - value:
    file-verbosity = {
      value = enumCheck ["quiet" "error" "warning" "info" "debug" "trace"] "file-verbosity" "";
    };
    - output:
      error: Invalid value for file-verbosity: "debu"
             Valid values are: "quiet, error, warning, info, debug, trace"
      (use '--show-trace' to show detailed location information)
  */

  enumCheck = enum: n: v: let
    check =
      if (l.tryEval ((std.yants.enum "" enum) v)).success
      then v
      else
        throw ''
          Invalid value for ${n}: "${v}"
          Valid values are: "${l.concatStringsSep ", " enum}"
        '';
  in
    check;
}
