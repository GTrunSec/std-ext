{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (cell) nomadJobs;
  inherit (inputs.cells._modules.library) makeConfiguration makeCommonNomad;

  name = builtins.baseNameOf ./.;
in {
  dev = makeCommonNomad name "dev" (nomadJobs.container.traefik {
    task = "dev";
  });
  prod = makeCommonNomad name "prod";
}
