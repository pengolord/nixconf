{types, ...}: {
  inputs.nixpkgs.path = "/nixpkgs";
  inputs.mkWrapper.path = "/mkWrapper";
  inputs.flake.path = "/flake";

  options = {
    settings = {
      type = types.attrs;
      description = ''
        Settings to be injected into the wrapped package's `config.toml`.

        See the noctalia docs for valid options:
        https://docs.noctalia.dev/v5

        Disjoint with the `configFile` option.
      '';
      default = import ./settings.nix;
    };
    configFile = {
      type = types.pathLike;
      description = ''
        `config.toml` file to be injected into the wrapped package.

        See the noctalia docs for valid options:
        https://docs.noctalia.dev/v5

        Disjoint with the `settings` option.
      '';
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
