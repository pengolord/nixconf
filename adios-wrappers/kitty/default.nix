_: {
  inputs.zsh.path = "/zsh";

  mutations."/zsh".zshrcFiles = {inputs}: let
    inherit (inputs.nixpkgs.pkgs) kitty writeText;
  in [
    (writeText "kitty.zsh" ''
      # === Kitty Terminal Compat ===
      alias ssh='${kitty}/bin/kitten ssh'
    '')
  ];

  options = {
    configFile.defaultFunc = {inputs}: let
      inherit (inputs.nixpkgs.lib) getExe;
      inherit (inputs.nixpkgs.pkgs) writeText;
      zsh = inputs.zsh {};
    in
      writeText "kitty.conf" ''
        background_opacity         0.7
        dynamic_background_opacity yes
        shell                      ${getExe zsh}

        include ~/.cache/matugen/kitty.conf
      '';

    theme.default = "";
  };
}
