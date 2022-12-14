{
  inputs,
  cell,
}: {
  name,
  julia ? inputs.cells.comonicon.packages.julia-wrapped,
  path ? "",
  args ? [],
  runtimeEnv ? {},
  threads ? 8,
  runtimeInputs ? [],
}: let
  inherit (cell) lib;
in
  lib.writeShellApplication {
    inherit name;
    runtimeEnv = runtimeEnv;
    runtimeInputs = [julia] ++ runtimeInputs;
    text = ''
      julia -e "import Pkg; Pkg.activate(\"${path}\"); Pkg.instantiate();" -L ${path}/${builtins.concatStringsSep " " args} "$@"
    '';
  }
