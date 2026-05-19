{
  sources,
  pkgs,
  ...
}: let
  mnw = import sources.mnw;
in
mnw.lib.wrap pkgs {
  neovim = pkgs.neovim-unwrapped;

  initLua = ''
    require('opts')
    require('keymaps')
    require('lz.n').load('plugins')
  '';

  plugins = {
    dev.config.pure = ./.;

    start = with pkgs.vimPlugins; [
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
      guess-indent-nvim

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
  };

  extraBinPath = with pkgs; [
    lua-language-server
    nixd
    rust-analyzer
    typescript-language-server
    java-language-server
  ];
}
