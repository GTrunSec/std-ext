{
  inputs,
  cell,
}: src: overrides: let
  inherit (inputs) std nixpkgs;
  l = nixpkgs.lib;
  lock = builtins.fromJSON (builtins.readFile ./lock/flake.lock);
  flake-compat = builtins.fetchTarball {
    url = "https://github.com/gtrunsec/flake-compat/archive/${lock.nodes.flake-compat.locked.rev}.tar.gz";
    sha256 = lock.nodes.flake-compat.locked.narHash;
  };
  lockFile = l.recursiveUpdate (builtins.fromJSON (builtins.readFile (src + "/flake.lock"))) {nodes = overrides;};
  compatFlake = import "${flake-compat}" {
    inherit lockFile src;
  };
in {
  nosys = std.inputs.paisano.inputs.nosys.lib.deSys nixpkgs.system compatFlake.defaultNix.inputs;
  withsys = compatFlake.defaultNix.inputs;
}
