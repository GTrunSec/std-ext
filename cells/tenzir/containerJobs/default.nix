{
  inputs,
  cell,
} @ args: let
  inherit (inputs.cells.containers.library) nixpkgs;
in {
  vast.compose = _args: import ./vast-compose.nix _args;
  vast.nix = version: {
    "${version}" = nixpkgs.callPackage ../containerJobs/nix/vast.nix {inherit version;} args;
  };
}
