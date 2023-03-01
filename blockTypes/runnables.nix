inputs: let
  inherit (inputs) nixpkgs std;
  inherit (std) sharedActions;

  lib = nixpkgs.lib // builtins;

  /*
  Use the Runnables Blocktype for targets that you want to
  make accessible with a 'run' action on the TUI.
  */
  runnables = name: {
    __functor = import "${std}/src/blocktypes/__functor.nix";
    inherit name;
    type = "runnables";
    actions = {
      currentSystem,
      fragment,
      fragmentRelPath,
      target,
    }:
      [
        (sharedActions.build currentSystem target)
        (sharedActions.run currentSystem target)
      ]
      ++ lib.optional (target ? process-compose) [
        ((sharedActions.run currentSystem target.process-compose) // {name = "ps";})
      ];
  };
in
  runnables
