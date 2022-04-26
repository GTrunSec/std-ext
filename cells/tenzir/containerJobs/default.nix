{
  inputs,
  cell,
} @ args: let
  inherit (inputs.cells.containers.library) nixpkgs;
in {
  vast = {
    compose = _args: import ./vast-compose.nix _args;
    nix = version: {
      "${version}" = nixpkgs.callPackage ./nix/vast.nix {inherit version;} args;
    };
  };
}
