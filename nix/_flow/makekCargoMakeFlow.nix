{
  inputs,
  cell,
}: {
  entrypoint ? "",
  name ? "cargo-make",
  runtimeInputs ? [],
  args ? [],
  ...
} @ _args: let
  inherit (inputs.cells._writers.library) writeShellApplication;
  inherit (inputs) nixpkgs;
  commands = nixpkgs.lib.concatStringsSep "\n" (map (c: ''cargo-make make --makefile ${_args.source} -t ${c} "$@"'') args);
in
  writeShellApplication {
    inherit name;
    runtimeInputs = [nixpkgs.cargo-make] ++ runtimeInputs;
    text = ''
      ${commands}
    '';
  }
  // _args
