{
  inputs,
  cell,
}: {
  job_a.tasks = {
    format = {
      description = "Runs the cargo rustfmt plugin.";
      command = "treefmt";
      args = [];
    };
  };
}
