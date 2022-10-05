{
  inputs,
  cell,
}: {
  name,
  julia ? inputs.nixpkgs.julia_18-bin,
  path ? "",
  args ? [],
  env ? {},
  threads ? 8,
  runtimeInputs ? [],
}: let
  inherit (cell) lib;
in
  lib.writeShellApplication {
    inherit name env;
    runtimeInputs = [julia] ++ runtimeInputs;
    text = ''
      manifest=${./_packages/comonicon}
      julia -e "import Pkg; Pkg.activate(\"$manifest\"); Pkg.instantiate();" -L ${path}/${builtins.concatStringsSep " " args} --threads ${toString threads} "$@"
    '';
  }
