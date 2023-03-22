{
  inputs,
  cell,
}: let
  inherit (inputs) std;
in {
  lefthook = std.nixago.lefthook {
    data = {
      pre-commit = {
        commands = {
          lint-then-fmt = {
            run = "just fmt {staged_files}";
            skip = ["merge" "rebase"];
          };
        };
      };
    };
  };
}
