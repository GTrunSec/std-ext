{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs spongix nomad-driver-nix;
  inherit (inputs.cells._writers.library) writeShellApplication;
in {
  dev-cluster = writeShellApplication {
    name = "dev-nomad";
    env = {
      secretFile = "${builtins.toFile "nix-cache-proxy.sec" "nix-cache-proxy:J5wXSq2iirA2sksFzfsV1fXoNQZFKh4QUOizy6b46sHI18Hb6kxKauM3IxFahvWgSziKE+dUo+QQJaIPG/Uw0g=="}";
      nomadPlugins = let
        path =
          nixpkgs.buildEnv
          {
            name = "nomad-plugins";
            paths = [nomad-driver-nix.defaultPackage nixpkgs.nomad-driver-podman];
          };
      in
        path;
      nomadConfig = "${nixpkgs.writeText "nomad.hcl" (builtins.toJSON {
        log_level = "TRACE";
        plugin.nix_driver = {};
        plugin.podman = {
          config = {
            enabled = true;
          };
        };
        client.host_volume = {
          mysql = {
            path = "/opt/nomad/mysql";
            read_only = false;
          };
          vast = {
            path = "/opt/nomad/vast";
            read_only = false;
          };
        };
        client.cni_path = "${nixpkgs.cni-plugins}/bin";
        vault = {
          enabled = true;
          address = "http://127.0.0.1:8200";
        };
      })}";
    };
    text = nixpkgs.lib.fileContents ./dev-cluster.bash;
    runtimeInputs = [nixpkgs.vault-bin nixpkgs.bash nixpkgs.netcat nixpkgs.nomad spongix.defaultPackage nixpkgs.consul];
  };
}
