{...}: {
  start = {
    # Prints the endpoint for clients when the server is ready to accept
    # connections. This comes in handy when letting the OS choose an
    # available random port, i.e., when specifying 0 as port value.
    print-endpoint = false;
  };
}
