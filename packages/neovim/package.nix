{
  inputs,
  pkgs,
  ...
}:
# Note: I am a horrible neovimmer. please do not copy this config
inputs.wrapper-modules.wrappers.neovim.wrap {
  inherit pkgs;

  settings.config_directory = ./.;

  specs.initLua = {
    data = null;
    before = ["MAIN_INIT"];
    config = ''
      require('init')
    '';
  };

  specs.general = with pkgs.vimPlugins; [
    # Simple plugin loader
    lz-n

    # Neovim utils
    lualine-nvim
    neo-tree-nvim
    plenary-nvim
    nvim-web-devicons
    nvim-lspconfig
    indent-blankline-nvim
    base16-nvim
    smart-splits-nvim

    # Completion
    blink-cmp

    # Treesitter
    (nvim-treesitter.withPlugins (
      plugins:
        with plugins; [
          java
          javascript
          lua
          nix
          rust
          typescript
        ]
    ))
  ];

  extraPackages = with pkgs; [
    lua-language-server
    nixd
    rust-analyzer
    typescript-language-server
    java-language-server
  ];
}
