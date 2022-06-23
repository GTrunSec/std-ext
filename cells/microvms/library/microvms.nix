inputs: let
  microvm = module: let
    nixosSystem = args:
      import "${inputs.nixpkgs.path}/nixos/lib/eval-config.nix" (args
        // {
          modules = args.modules;
        });
  in
    nixosSystem {
      inherit (inputs.nixpkgs) system;
      modules = [
        # for declarative MicroVM management
        inputs.microvm.nixosModules.host
        # this runs as a MicroVM that nests MicroVMs
        inputs.microvm.nixosModules.microvm
        # your custom module
        module
      ];
    };
in
  microvm
