{
  inputs,
  cell,
}: src: overrides: let
  inherit (inputs) std nixpkgs;
  l = nixpkgs.lib;
  flake-compat = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/GTrunSec/flake-compat/lockFile/default.nix";
    sha256 = "sha256:0i65hifh0z5nxnnn4dy1rgcp0jqkypb95xrk8ksyland8l1ziap6";
  };
  lockFile = l.recursiveUpdate (builtins.fromJSON (builtins.readFile (src + "/flake.lock"))) {nodes = overrides;};
  compatFlake = import "${flake-compat}" {
    inherit lockFile src;
  };
in
  std.deSystemize nixpkgs.system compatFlake.defaultNix.inputs
