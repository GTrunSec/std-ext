{
  inputs,
  cell,
}: let
  inherit (inputs.cells.writers.lib) writeConfig;
in {
  sync = {
    branch ? "",
    infra ? "",
    name ? "",
  }: {
    tasks = {
      copy = {
        description = "rsync the files to infra";
        command = "rsync";
        args = ["-avzh"] ++ [];
      };
    };
  };
}
