{
  inputs,
  cell,
}: {
  default = _: {
    commands = [
      {
        name = "emacs-test";
        command = ''
          nix run $RPJ_ROOT#x86_64-linux.emacs.entrypoints.emacs-test \
          --option extra-substituters https://microvm.cachix.org \
          --option extra-trusted-public-keys microvm.cachix.org-1:oXnBc6hRE3eX5rSYdRyMYXnfzcCxC7yKPTbZXALsqys=
        '';
      }
    ];
  };
}
