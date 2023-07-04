{
  cell,
  inputs,
}: {
  container = {
    elasticsearch = import ./elasticsearch.nix;
    kibana = import ./kibana.nix;
    traefik = _args: import ./traefik _args {inherit inputs;};
  };

  nixos = {
    airflow = import ./nixos-airflow.nix;
    waterwheel = import ./nixos-waterwheel.nix;
  };
}
