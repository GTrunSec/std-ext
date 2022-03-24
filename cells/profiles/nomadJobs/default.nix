{
  cell,
  inputs,
} @ args: {
  elasticsearch = args: import ./elasticsearch.nix args {inherit args;};
}
