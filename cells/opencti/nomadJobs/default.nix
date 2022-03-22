{
  inputs,
  cell,
}: {
  opencti-compose = args: import ./opencti-docker-compose.nix args;
}
