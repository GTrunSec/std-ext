let MyConfig = {
  path | doc m%%"
	__argAggregate__
	"%%m
       | Str,

  connection | {
    server_port | Port,
    host | Str,
  }
}
in

{
  path = "/foo/bar",
  connection = {
    server_port =
      if host == "localhost" then
        8080
      else
        80,
    host = "localhost",
  }
} | MyConfig
