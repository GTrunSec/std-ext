{
  inputs,
  cell,
}: src: overrides: let
  inherit (inputs) std nixpkgs;
  l = nixpkgs.lib;
  flake-compat = builtins.fetchTarball {
    url = "https://github.com/gtrunsec/flake-compat/archive/lockFile.tar.gz";
    sha256 = "sha256:157zd0xs1qz0synqlphr8xa5cfvflascbv021gwci0w4cgyjmfag";
  };
  lockFile = l.recursiveUpdate (builtins.fromJSON (builtins.readFile (src + "/flake.lock"))) {nodes = overrides;};
  compatFlake = import "${flake-compat}" {
    inherit lockFile src;
  };
in
  std.deSystemize nixpkgs.system compatFlake.defaultNix.inputs
