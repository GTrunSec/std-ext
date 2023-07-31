{ inputs, cell }:
{
  default.tasks = {
    format = {
      description = "Runs the treefmt format";
      command = "treefmt";
      args = [ ];
    };
  };
}
