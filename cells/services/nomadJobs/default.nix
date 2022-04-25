{
  cell,
  inputs,
}: {
  container = {
    elasticsearch = _args: import ./elasticsearch.nix _args;
    kibana = _args: import ./kibana.nix _args;
    traefik = _args: import ./traefik _args {inherit inputs;};
  };

  nixos = {
    airflow = _args: import ./nixos-airflow.nix _args;
    waterwheel = _args: import ./nixos-waterwheel.nix _args;
  };
}
