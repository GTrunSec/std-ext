{
  inputs,
  cell,
}: let
  inherit (inputs.cells._writers.library) writeConfiguration;
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
