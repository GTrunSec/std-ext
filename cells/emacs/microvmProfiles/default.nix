{
  inputs,
  cell,
}: let
  microvm = inputs.std-microvm.std.lib.fromMicrovmWith inputs;
in {
  inherit (inputs) nixpkgs;
  task = microvm ({
    pkgs,
    lib,
    ...
  }: {networking.hostName = "microvms-host";});

  test = inputs.lambda-microvm-lab.nixosConfigurations.user-qemu-host.extendModules {
    modules = [
      cell.nixosProfiles.override
      {
        # make home-manager writable
        microvm.writableStoreOverlay = "/nix/var/nix/temproots";
      }
    ];
  };
}
