_: {
  inputs = {
    flake.path = "/flake";
    git.path = "/git";
  };

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

    extraPackages.defaultFunc = {inputs}: [
      (inputs.git {})
      inputs.flake.pkgs.neovim
      inputs.nixpkgs.pkgs.eza
    ];
  };
}
