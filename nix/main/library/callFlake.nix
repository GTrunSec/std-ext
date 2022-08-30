{
  inputs,
  cell,
}: src: overrides: let
  inherit (inputs) self std nixpkgs;
  l = nixpkgs.lib;
  lockFile = l.recursiveUpdate (builtins.fromJSON (builtins.readFile (src + "/flake.lock"))) overrides;
  compatFlake = import "${inputs.flake-compat}" {
    inherit lockFile src;
  };
in
  std.deSystemize nixpkgs.system compatFlake.defaultNix.inputs
