{
  inputs,
  system,
}:
let
  nixpkgs = inputs.nixpkgs;
  packages = inputs.self.packages.${system.host.system};
in
{
  "" = _: {
    commands = [
      {
        name = "julia";
        package = nixpkgs.julia_17-bin;
        category = "julia";
      }
      {
        name = "mycmd";
        command = ''
          cd $CELL_ROOT/comonicon
          julia -e "import Pkg; Pkg.activate(\".\"); Pkg.instantiate()" -L mycmd.jl -- $@
        '';
        category = "julia";
      }
    ];
  };
}
