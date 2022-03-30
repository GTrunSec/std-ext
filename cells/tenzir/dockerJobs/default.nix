{
  inputs,
  cell,
}: rec {
  vast.compose = _args: import ./vast-compose.nix _args;
}
