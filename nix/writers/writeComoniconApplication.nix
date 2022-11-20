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
  manifest ? ./packages/comonicon,
}: let
  inherit (cell) lib;
in
  lib.writeShellApplication {
    inherit name;
    runtimeEnv =
      runtimeEnv
      // {
        inherit manifest;
      };
    runtimeInputs = [inputs.cells.comonicon.packages.julia-wrapped] ++ runtimeInputs;
    text = ''
      julia -e "import Pkg; Pkg.activate(\"$manifest\"); Pkg.instantiate();" -L ${path}/${builtins.concatStringsSep " " args} "$@"
    '';
  }
