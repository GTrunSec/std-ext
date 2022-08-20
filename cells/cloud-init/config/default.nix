{
  inputs,
  cell,
} @ args: {
  default = {
    description = ''
      https://cloudinit.readthedocs.io/en/latest/topics/examples.html
    '';
    values = {
      chpasswd = {
        list = ["root:terraform-libvirt-linux"];
        expire = "False";
      };
    };
  };
  usersGroups = {
    values = import ./usersGroups.nix args;
  };
}
