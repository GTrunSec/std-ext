{
  inputs,
  cell,
} @ args: let
  inherit (inputs.nixpkgs) glibcLocales;

  writeClicheApplication = _args: import ./writeClicheApplication.nix args _args;

  writeShellApplication = _args: import ./writeShellApplication.nix args _args;

  writePiplelineApplication = _args: import ./writePiplelineApplication.nix args _args;

  writeComoniconApplication = _args: import ./writeComoniconApplication.nix args _args;
in {
  inherit writeClicheApplication writePiplelineApplication writeComoniconApplication;

  writeShellApplication = {...} @ args:
    writeShellApplication (
      args
      // {
        text = ''
          export LOCALE_ARCHIVE=${glibcLocales}/lib/locale/locale-archive
          ${args.text}
        '';
      }
    );
}
