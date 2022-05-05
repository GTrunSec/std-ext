{
  inputs,
  cell,
}: {
  job_a.tasks = {
    format = {
      description = "Runs the treefmt format";
      command = "treefmt";
      args = [];
    };
  };
}
