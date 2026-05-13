_: {
  inputs.nushell.path = "/nushell";

  options = {
    configFile.defaultFunc = {inputs}: let
      inherit (inputs.nixpkgs.lib) getExe;
      inherit (inputs.nixpkgs.pkgs) writeText;
      nushell = inputs.nushell {};
    in
      writeText "kitty.conf" ''
        background_opacity         0.7
        dynamic_background_opacity yes
        shell                      ${getExe nushell}

        include ~/.cache/matugen/kitty.conf
      '';

    theme.default = "";
  };
}
