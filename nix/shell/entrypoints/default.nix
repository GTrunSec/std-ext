{
  inputs,
  cell,
}: let
  l = inputs.nixpkgs.lib // builtins;
  inherit (cell) packages;
  inherit (inputs.std-ext.writers.lib) writeShellApplication;
in {
  inherit (inputs.cells.utils.entrypoints) polars;
  inherit (inputs.cells.julia.entrypoints) cli;

  nu = writeShellApplication {
    name = "nu";
    runtimeInputs = [packages.nushell];
    text = ''
      nu -c 'register ${l.getExe packages.nu-plugin-regex}' && \
      nu -c 'register ${l.getExe packages.nu-plugin-from-parquet}'
      nu "$@"
    '';
  };
}
