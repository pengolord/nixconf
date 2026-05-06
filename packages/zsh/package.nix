{
  inputs,
  lib,
  pkgs,
  pkgs-self,
  ...
}: let
  inherit (lib) getExe;

  inherit (pkgs-self) git neovim;
  inherit (pkgs) eza zsh-syntax-highlighting zsh-autosuggestions;
in
  inputs.wrapper-modules.wrappers.zsh.wrap (
    {config, ...}: {
      options = {
        zshrc-sources = lib.mkOption {
          type = lib.types.listOf lib.types.anything;
          description = "Files sourced into zshrc";
        };
      };

      config = {
        inherit pkgs;
        zshrc.content = ''
          # === Dependencies ===
          alias git='${getExe git}'
          alias ls='${getExe eza}'
          alias nvim='${getExe neovim}'

          # === Zsh Addons ===
          source ${zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
          source ${zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh

          # === Environment Variables ===
          export EDITOR=nvim

          ${builtins.concatStringsSep "\n" (map (file: "source ${file}") config.zshrc-sources)}

        '';

        zshrc-sources = [
          ./aliases.zsh
          ./prompt.zsh
        ];
      };
    }
  )
