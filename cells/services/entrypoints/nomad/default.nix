{
  inputs,
  cell,
} @ args: let
in {
  airflow = import ./airflow.nix args;

  waterwheel = import ./waterwheel.nix args;

  elasticsearch = import ./elasticsearch.nix args;

  traefik = import ./traefik.nix args;
}
