{ inputs, lib, pkgs-self, pkgs-unstable, ... }:

let
  wrapper = inputs.wrapper-modules.lib.evalModule ./wrapper.nix;

  inherit (lib) getExe;

  inherit (pkgs-unstable) kitty;
  zsh = pkgs-self.zsh.wrap {
    zshrc-sources = [(
      pkgs-unstable.writeText "kitty.zsh" ''
        # === Kitty Terminal Compat ===
        alias ssh='${kitty}/bin/kitten ssh'
      ''
    )];
  };
in
wrapper.config.wrap {
  pkgs = pkgs-unstable;

  configFile.content = ''
    background_opacity         0.7
    dynamic_background_opacity yes
    shell                      ${getExe zsh}

    include ~/.cache/matugen/kitty.conf
  '';
}
