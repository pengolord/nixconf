_: {
  inputs.self.path = "/self";

  mutations."/zsh".zshrcFiles = _: [
    ./config/aliases.zsh
    ./config/prompt.zsh
  ];

  options = {
    zshrcFiles.mutators = ["/kitty" "/zsh"];

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
