_final: prev: {
  nomad = prev.callPackage "${prev.path}/pkgs/applications/networking/cluster/nomad/generic.nix" {
    inherit (prev) buildGoModule;
    nvidiaGpuSupport = false;
    inherit (prev.linuxPackages) nvidia_x11;
    version = "1.3.1";
    sha256 = "sha256-p0pkOlPjDYcMV7XAhEbUO8PE0wNqAjTmgtv+XiCGkw0=";
    vendorSha256 = "sha256-8LkJi+MwmLQkL/ZXWOGhJk6tIAmsJm/qBFhkglVvZSI=";
  };
}
