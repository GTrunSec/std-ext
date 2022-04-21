{
  cell,
  inputs,
}: {
  container.elasticsearch = args: import ./elasticsearch.nix args {inherit args;};
  container.kibana = args: import ./kibana.nix args {inherit args;};
  nixos = {
    airflow = _args: import ./nixos-airflow.nix _args;
    waterwheel = _args: import ./nixos-waterwheel.nix _args;
  };
}
