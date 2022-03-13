# Document Title

    Nickel library for Nickel-Nix interoperability. Provide contracts used to
    serialize Nix inputs to Nickel, to define a Nickel expression, and helpers
    to build strings which preserves Nix string contexts.

##nix

```nix
shellHook = nickel_string_hack [ 
  m%"echo "Development shell""%m,
  pkgs.hello,                    
  "/bin/hello"                   
]      
```
