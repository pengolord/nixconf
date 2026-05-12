{types, ...}: {
  options = {
    inputs.type = types.attrs;
    pkgs.type = types.attrs;
    system.type = types.string;
  };
}
