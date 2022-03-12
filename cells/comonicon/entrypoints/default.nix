{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (inputs.cells._writers.library) writeShellApplication;
in {
  mycmd = writeShellApplication {
    name = "mycmd-comonicon";
    runtimeInputs = [nixpkgs.julia_17-bin];
    text = ''
      cd "$CELL_ROOT/comonicon"
      julia -e "import Pkg; Pkg.activate(\".\"); Pkg.instantiate()" -L entrypoints/mycmd.jl -- "$@"
    '';
  };
}
