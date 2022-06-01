{
  inputs,
  cell,
}: let
  inherit (inputs.cells._writers.library) writeShellApplication;
  inherit (inputs) nixpkgs;
in {
  emacs-test = writeShellApplication {
    name = "emacs-test";
    runtimeInputs = [nixpkgs.nixUnstable];
    text = ''
      nix run ${cell.nixosProfiles.emacs-test.config.microvm.runner.qemu} \
      --option extra-substituters https://microvm.cachix.org \
      --option extra-trusted-public-keys microvm.cachix.org-1:oXnBc6hRE3eX5rSYdRyMYXnfzcCxC7yKPTbZXALsqys=
    '';
  };
}
