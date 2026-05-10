{ types, ... }: {
  inputs.nixpkgs.path = "/nixpkgs";
  inputs.mkWrapper.path = "/mkWrapper";

  options = {
    settings = {
      type = types.string;
      default = import ./templates;
    };
    package = {
      type = types.derivation;
      description = "The matugen package to be wrapped.";
      defaultFunc = { inputs }: inputs.nixpkgs.pkgs.matugen;
    };
  };

  impl = { options, inputs }: let
    generator = inputs.nixpkgs.pkgs.writeText "";
  in
    inputs.mkWrapper {
      inherit (options) package;
      preSymlink = ''
        mkdir -p $out/matugen
      '';
      symlinks."$out/matugen/config.toml" = generator options.settings;
      flags = [ "-c" "$out/matugen/config.toml" ];
    };
}
