{
  inputs,
  cell,
}: {
  name,
  julia ? {
    package = inputs.cells.comonicon.packages.julia-wrapped;
    pure = false;
  },
  path ? "",
  args ? [],
  runtimeEnv ? {},
  threads ? 8,
  runtimeInputs ? [],
  pure ? false,
}: let
  inherit (cell) lib;
  l = inputs.nixpkgs.lib // builtins;
in
  lib.writeShellApplication {
    inherit name;
    runtimeEnv = runtimeEnv;
    runtimeInputs = runtimeInputs;
    text =
      l.optionalString julia.pure ''
        ${l.getExe julia.package} ${path}/${builtins.concatStringsSep " " args} "$@"
      ''
      + l.optionalString (!julia.pure) ''
        ${l.getExe julia.package} -e "import Pkg; Pkg.activate(\"${path}\"); Pkg.instantiate();" -L julia ${path}/${builtins.concatStringsSep " " args} "$@"
      '';
  }
