{
  inputs,
  cell,
}: {
  name,
  julia ? inputs.nixpkgs.julia_18-bin,
  path ? "",
  args ? [],
  runtimeEnv ? {},
  threads ? 8,
  runtimeInputs ? [],
}: let
  inherit (cell) lib;
  julia = inputs.cells.comonicon.packages.julia-wrapped;
in
  lib.writeShellApplication {
    inherit name;
    runtimeEnv =
      runtimeEnv
      // {
        manifest = path;
      };
    runtimeInputs = [julia] ++ runtimeInputs;
    text = ''
      julia -e "import Pkg; Pkg.activate(\"$manifest\"); Pkg.instantiate();" -L ${path}/${builtins.concatStringsSep " " args} "$@"
    '';
  }
