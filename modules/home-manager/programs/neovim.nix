{
  config,
  lib,
  pkgs,
  ...
}: let
  toLua = str: "lua << EOF\n${str}\nEOF\n";
  toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
in {
  options = {
    modules.programs.neovim.enable = lib.mkEnableOption "Layer-based, hyperextensible text editor";
  };

  config = lib.mkIf config.modules.programs.neovim.enable {
    programs.neovim = {
      enable = true;

      # Extra packages we need for some stuff to work
      extraPackages = with pkgs; [
        lua-language-server
        nil
        alejandra
      ];

      extraLuaConfig = ''
        ${builtins.readFile ./conf/options.lua}
        ${builtins.readFile ./conf/whichkey.lua}
        ${builtins.readFile ./conf/telescope.lua}
        ${builtins.readFile ./conf/lspconfig.lua}
        ${builtins.readFile ./conf/formatting.lua}
        ${builtins.readFile ./conf/autocomplete.lua}
        ${builtins.readFile ./conf/mini.lua}
        ${builtins.readFile ./conf/treesitter.lua}
        ${builtins.readFile ./conf/neotree.lua}
        ${builtins.readFile ./conf/autopairs.lua}
        ${builtins.readFile ./conf/lualine.lua}
      '';

      plugins = with pkgs.vimPlugins; [
        gitsigns-nvim # Adds symbols to gutter to signify git diffs # TODO: Maybe want to config this?
        which-key-nvim # Adds a popup window describing what keys perform what actions
        telescope-nvim # Lets you fly around
        conform-nvim # Formatting
        mini-nvim # Collection of neat little plugins
        neo-tree-nvim # File tree
        nvim-autopairs # Creates symbol pairs automatically
        lualine-nvim # Statusline

        # LSP Config
        lsp-zero-nvim
        nvim-lspconfig

        # Completions and snippets
        luasnip
        cmp-nvim-lsp
        cmp-path
        nvim-cmp

        # Treesitter
        (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-json
        ]))

        # Alpha, startup page
        {
          plugin = alpha-nvim;
          config = toLua "require('alpha').setup(require('alpha.themes.startify').config)";
        }

        # Rooter, automatically sets root directory for stuff lspconfig doesn't catch
        {
          plugin = lsp-rooter-nvim;
          config = toLua "require('lsp-rooter').setup()";
        }
      ];
    };
  };
}
