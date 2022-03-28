{
  inputs,
  cell,
} @ args: rec {
  compose = _args: import ./compose.nix _args;
}
