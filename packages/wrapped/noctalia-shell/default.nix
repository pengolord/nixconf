{types, ...}: {
  inputs.nixpkgs.path = "/nixpkgs";
  inputs.mkWrapper.path = "/mkWrapper";
  inputs.flake.path = "/flake";

  options = {
    settings = {
      type = types.attrs;
      defaultFunc = {inputs}: import ./settings.nix inputs;
    };
    package = {
      type = types.derivation;
      description = "The noctalia package to be wrapped.";
      defaultFunc = {inputs}: inputs.flake.inputs.noctalia-shell.packages.${inputs.flake.system}.default;
    };
  };

  impl = {
    options,
    inputs,
  }: let
    generator = inputs.nixpkgs.pkgs.formats.toml {};
  in
    inputs.mkWrapper {
      inherit (options) package;
      preSymlink = ''
        mkdir -p $out/noctalia
      '';
      symlinks."$out/noctalia/noctalia.toml" = generator.generate "noctalia.toml" options.settings;
      environment.NOCTALIA_CONFIG_HOME = "$out";
    };
}
