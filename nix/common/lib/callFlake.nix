{
  inputs,
  cell,
  nosys ? true,
}: src: override-inputs: let
  inherit (inputs) std nixpkgs;
  lock = builtins.fromJSON (builtins.readFile ./lock/flake.lock);
  flake-compat = builtins.fetchTarball {
    url = "https://github.com/gtrunsec/flake-compat/archive/${lock.nodes.flake-compat.locked.rev}.tar.gz";
    sha256 = lock.nodes.flake-compat.locked.narHash;
  };
  compatFlake = import "${flake-compat}" {
    inherit src override-inputs;
  };
in
  if nosys
  then std.inputs.paisano.inputs.nosys.lib.deSys nixpkgs.system compatFlake.defaultNix.inputs
  else compatFlake.defaultNix.inputs
