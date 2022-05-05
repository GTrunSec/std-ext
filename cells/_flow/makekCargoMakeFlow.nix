{
  inputs,
  cell,
}: {
  entrypoint ? "",
  name ? "cargo-make",
  runtimeInputs ? [],
  ...
} @ _args: let
  inherit (inputs.cells._writers.library) writeShellApplication;
  inherit (inputs) nixpkgs;
in
  writeShellApplication {
    inherit name;
    runtimeInputs = [nixpkgs.cargo-make] ++ runtimeInputs;
    text = ''
      cargo-make make --makefile ${_args.source} "$@"
    '';
  }
  // _args
