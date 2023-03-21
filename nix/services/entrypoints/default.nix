{
  inputs,
  cell,
}: {}
# {
#   inputs,
#   cell,
# } @ args: let
#   inherit ((inputs.nixpkgs.appendOverlays [
#       (_final: prev: {
#         lib = prev.lib.extend (import ../../_lib/extend.nix {inherit inputs;});
#       })
#     ])) lib;
# in
#   {
#   }
#   // (lib.makeNestedJobs [
#       ./nomad
#     ]
#     args)

