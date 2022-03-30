{
  inputs,
  cell,
}: rec {
  container = _args: import ./container.nix _args {inherit inputs cell;};
  hydration =
    container {
    };
}
