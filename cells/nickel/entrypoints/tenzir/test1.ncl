{
  name = "hello",
  version = "0.1.1",
  fullname =
  if builtins.is_num version then
      "hello-v#{strings.fromNum version}"
     else
      "hello-#{version}",
}
