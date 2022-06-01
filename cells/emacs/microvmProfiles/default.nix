{
  inputs,
  cell,
}: {
  emacs-test = inputs.lambda-microvm-lab.nixosConfigurations.user-qemu-host.extendModules {
    modules = [
      cell.nixosProfiles.overrideInputs
      {
        # make home-manager writable
        microvm.writableStoreOverlay = "/nix/var/nix/temproots";
      }
    ];
  };
}
