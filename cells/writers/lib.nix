{ inputs, cell }@args:
let
  inherit (inputs) nixpkgs;

  l = nixpkgs.lib // builtins;

  writeClicheApplication = import ./writeClicheApplication.nix args;

  writePiplelineApplication = import ./writePiplelineApplication.nix args;

  writeComoniconApplication = import ./writeComoniconApplication.nix args;

  writeConfiguration = import ./writeConfiguration.nix args;

  writeShellApplication = import ./writeShellApplication.nix args;
in
{
  inherit
    writeClicheApplication
    writePiplelineApplication
    writeComoniconApplication
    writeConfiguration
  ;

  /* doc = writeGlowDoc {
       name = "CLI Docs"
       src ="${std.incl self [
         (self + /docs)
       ]}/docs";
       tip = ''
       example: just doc `flag`
       '';
       extraMd = ./default.md;
     };
  */

  writeGlowDoc = import ./writeGlowDoc.nix args;

  writeConfig = import ./writeConfig.nix args;

  writeShellApplication =
    {
      passthru ? { },
      ...
    }@args:
    (writeShellApplication (
      (l.removeAttrs args [ "passthru" ])
      // {
        text = ''
           ${
             l.optionalString (nixpkgs.stdenv.hostPlatform.libc == "glibc") ''
               export LOCALE_ARCHIVE=${
                 nixpkgs.glibcLocales.override { allLocales = false; }
               }/lib/locale/locale-archive
             ''
           }
          ${args.text}
        '';
      }
    )).overrideAttrs
      (old: { inherit passthru; });
}
