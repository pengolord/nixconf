{
  inputs,
  lib,
  pkgs-self,
  pkgs,
  ...
}: let
  wrapper = inputs.wrapper-modules.lib.evalModule ./wrapper.nix;

  inherit (lib) getExe;

  inherit (pkgs) kitty;
  zsh = pkgs-self.zsh.wrap {
    zshrc-sources = [
      (
        pkgs.writeText "kitty.zsh" ''
          # === Kitty Terminal Compat ===
          alias ssh='${kitty}/bin/kitten ssh'
        ''
      )
    ];
  };
in
  wrapper.config.wrap {
    inherit pkgs;

    configFile.content = ''
      background_opacity         0.7
      dynamic_background_opacity yes
      shell                      ${getExe zsh}

      include ~/.cache/matugen/kitty.conf
    '';
  }
