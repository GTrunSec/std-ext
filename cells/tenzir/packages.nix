{
  inputs,
  system,
}: let
  nixpkgs = inputs.nixpkgs;
  vast = inputs.vast2nix.packages.${system.host.system};
  threatbus2nix = inputs.threatbus2nix.packages.${system.host.system};
in {
  vast-release = vast.vast-release;
  threatbus = threatbus2nix.threatbus;
}
