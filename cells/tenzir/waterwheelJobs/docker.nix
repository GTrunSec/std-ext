{...}: let
in {
  tasks = {
    name = "step1";
    image = "bash:latest";
    args = ["-c" "echo step1"];
    depends = ["trigger/daily"];
  };
}
