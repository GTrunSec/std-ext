{
  cell,
  inputs,
} @ args: {
  elasticsearch = args: import ./elasticsearch.nix args {inherit args;};
  kibana = args: import ./kibana.nix args {inherit args;};
  nixos-airflow = _args: import ./nixos-airflow.nix _args;
}
