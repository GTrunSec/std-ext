{
  inputs,
  cell,
}:
{
  name,
  julia ? inputs.nixpkgs.julia_17-bin,
  path ? "",
  args ? [],
  env ? {},
  threads ? 8,
  runtimeInputs ? [],
}:
let
  inherit (inputs) nixpkgs;
  inherit (cell) library;
in
library.writeShellApplication {
  inherit name env;
  runtimeInputs = [julia] ++ runtimeInputs;
  text = ''
  manifest=$CELL_ROOT/_writers/_packages/jobSchedulers
  julia -e "import Pkg; Pkg.activate(\"$manifest\"); Pkg.instantiate();" -L ${path}/${builtins.concatStringsSep " " args} --threads ${toString threads} "$@"
  '';
}
