{
  cell,
  inputs,
} @ args: {
  elasticsearch = args: import ./elasticsearch.nix args {inherit args;};
  kibana = args: import ./kibana.nix args {inherit args;};
}
