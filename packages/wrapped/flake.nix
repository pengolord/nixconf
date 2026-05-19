{types, ...}: {
  options = {
    sources.type = types.attrs;
    inputs.type = types.attrs;
    pkgs.type = types.attrs;
    system.type = types.string;
  };
}
