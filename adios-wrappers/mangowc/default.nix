_: {
  inputs.self.path = "/self";

  options = {
    configFile.defaultFunc = {inputs}: let
      inherit (inputs.nixpkgs.pkgs) writeText;
      toMango = import ./toMango.nix inputs.nixpkgs.lib;
    in
      writeText "config.conf" (toMango {} (import ./settings.nix inputs));
  };
}
