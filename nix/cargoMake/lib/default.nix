{
  inputs,
  cell,
}: let
  inherit (inputs.cells._writers.lib) writeConfiguration;
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
