{
  inputs,
  cell,
}: rec {
  container = _args: import ./container.nix _args {inherit inputs cell;};
  nixos-node = _args: import ./opencti-nixos-node.nix _args;
  hydration =
    container {
    };
}
