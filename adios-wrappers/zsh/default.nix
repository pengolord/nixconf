_: {
  inputs.self.path = "/self";

  options = {
    zshrcFiles.default = [
      ./config/aliases.zsh
      ./config/prompt.zsh
    ];

    extraZshrc.default = ''
      export EDITOR=nvim
    '';

    plugins.defaultFunc = {inputs}:
      with inputs.nixpkgs.pkgs; [
        zsh-autosuggestions
        zsh-syntax-highlighting
      ];

    extraPackages.defaultFunc = {inputs}:
      with inputs.nixpkgs.pkgs // inputs.self.pkgs; [
        eza
        git
        neovim
      ];
  };
}
