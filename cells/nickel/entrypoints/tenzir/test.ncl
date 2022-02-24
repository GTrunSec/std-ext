let Schema = {
  name | Str
       | doc "Name of the package",
  version | #PkgVersion,
          | doc "The semantic version of the package",
          | default = "1.0.0",
  build | List #BuildSteps,
	      | doc "The steps to perform in order to build the package",
        | default = [],
} in
{
  name = "hello",
  build = [
    command "gcc hello.c -o hello",
    command "mv hello $out"

  ],
} | #Schema
