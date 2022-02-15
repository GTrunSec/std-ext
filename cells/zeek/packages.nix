{ inputs
, system
}:
let
  nixpkgs = inputs.nixpkgs;
  zeek2nix = inputs.zeek2nix.packages.${system.host.system};
in
{
  zeek-release = zeek2nix.zeek-release;
  btest = zeek2nix.btest;
}
