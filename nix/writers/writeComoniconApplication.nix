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
in
  lib.writeShellApplication {
    inherit name runtimeEnv;
    runtimeInputs = [inputs.cells.comonicon.packages.julia-wrapped] ++ runtimeInputs;
    text = ''
      manifest=${./packages/comonicon}
      julia -e "import Pkg; Pkg.activate(\"$manifest\"); Pkg.instantiate();" -L ${path}/${builtins.concatStringsSep " " args} "$@"
    '';
  }
