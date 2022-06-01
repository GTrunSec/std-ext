{
  inputs,
  cell,
}: {
  emacs-test = inputs.lambda-microvm-lab.nixosConfigurations.user-qemu-host.extendModules {
    modules = [
      ./overrideInput.nix
    ];
  };
}
