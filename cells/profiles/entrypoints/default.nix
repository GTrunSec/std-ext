{
  inputs,
  cell,
} @ args: {
  nomad-container-elasticsearch-dev = (import ./nomad-container-elasticsearch args).dev;

  nomad-nixos-airflow-dev = (import ./nomad-container-elasticsearch args).dev;
}
