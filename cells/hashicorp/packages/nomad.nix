_final: prev: {
  nomad = prev.callPackage "${prev.path}/pkgs/applications/networking/cluster/nomad/generic.nix" {
    inherit (prev) buildGoModule;
    version = "1.3.3";
    sha256 = "sha256-/63QGknivXyBel2MhMzbh/rE+UrfV3mb+zPZzOU15WU=";
    vendorSha256 = "sha256-5ubJ6hgpdkZd/hwy+u2S6XgQLD5xmgUnaUqJoLdguBQ=";
  };
}
