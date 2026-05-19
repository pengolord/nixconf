_: {
  inputs.flake.path = "/flake";
  inputs.kitty.path = "/kitty";
  inputs.noctalia-shell.path = "/noctalia-shell";

  options = {
    configFile.defaultFunc = {inputs}: let
      inherit (inputs.nixpkgs.pkgs) writeText;
      toMango = import ./toMango.nix inputs.nixpkgs.lib;
    in
      writeText "config.conf" (toMango {} (import ./settings.nix inputs));

    package.defaultFunc = {inputs}: let
      inherit (inputs.nixpkgs) pkgs;
      mangowm = "${inputs.flake.sources.mangowm}/nix";
    in
      pkgs.callPackage mangowm {};
  };
}
