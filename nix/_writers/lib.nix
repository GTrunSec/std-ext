{
  inputs,
  cell,
} @ args: let
  inherit (inputs.cells.main.lib) l;
  inherit (inputs) nixpkgs;

  writeClicheApplication = _args: import ./writeClicheApplication.nix args _args;

  writeShellApplication = _args: import ./writeShellApplication.nix args _args;

  writePiplelineApplication = _args: import ./writePiplelineApplication.nix args _args;

  writeComoniconApplication = _args: import ./writeComoniconApplication.nix args _args;

  writeConfiguration = _args: import ./writeConfiguration.nix args _args;
in {
  inherit
    writeClicheApplication
    writePiplelineApplication
    writeComoniconApplication
    writeConfiguration
    ;

  /*
  doc = writeGlowDoc {
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

  writeGlowDoc = _args: import ./writeGlowDoc.nix args _args;

  writeConfig = _args: import ./writeConfig.nix args _args;

  writeShellApplication = {...} @ args:
    writeShellApplication (
      args
      // {
        text = ''
           ${l.optionalString (nixpkgs.stdenv.hostPlatform.libc == "glibc") ''
            export LOCALE_ARCHIVE=${
              nixpkgs.glibcLocales.override {allLocales = false;}
            }/lib/locale/locale-archive
          ''}
          ${args.text}
        '';
      }
    );
}
