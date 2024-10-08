{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [<home-manager/nixos>];

  options = {
    modules.dev.neovim.enable = lib.mkEnableOption "Enables neovim and configuration";
  };

  config = lib.mkIf config.modules.dev.neovim.enable {
    home-manager.users.stormytuna.programs.neovim = let
      toLua = str: "lua << EOF\n${str}\nEOF\n";
      toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
    in {
      enable = true;
      defaultEditor = true;

      # Creates shell aliases for better compatibility with other things opening vi/vim
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      # Extra packages we need for some stuff to work
      extraPackages = with pkgs; [
        lua-language-server
        nil
        alejandra
      ];

      extraLuaConfig = ''
        ${builtins.readFile ./conf/nvim/options.lua}
        ${builtins.readFile ./conf/nvim/whichkey.lua}
        ${builtins.readFile ./conf/nvim/telescope.lua}
        ${builtins.readFile ./conf/nvim/lspconfig.lua}
        ${builtins.readFile ./conf/nvim/formatting.lua}
        ${builtins.readFile ./conf/nvim/autocomplete.lua}
        ${builtins.readFile ./conf/nvim/mini.lua}
        ${builtins.readFile ./conf/nvim/treesitter.lua}
        ${builtins.readFile ./conf/nvim/neotree.lua}
        ${builtins.readFile ./conf/nvim/autopairs.lua}
        ${builtins.readFile ./conf/nvim/lualine.lua}
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
