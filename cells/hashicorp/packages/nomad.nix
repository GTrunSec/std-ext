final: prev: {
  nomad = prev.callPackage "${prev.path}/pkgs/applications/networking/cluster/nomad/generic.nix" {
    inherit (prev) buildGoModule;
    nvidiaGpuSupport = false;
    inherit (prev.linuxPackages) nvidia_x11;
    version = "1.3.0-beta.1";
    sha256 = "sha256-mANDsYWETYIOrHZpLZawx2L/qrKLdFDP+Gtt3WCKx5s=";
    vendorSha256 = "sha256-LYGQHdiAnc2PkcEmzEhwk6nYS/iu9VsY881MR1qGCpw=";
  };
}
