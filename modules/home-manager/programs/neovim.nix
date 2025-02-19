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
    /*
    programs.nvf = {
      enable = true;
      settings.vim = {
        useSystemClipboard = true;

        statusline.lualine.enable = true;
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;

        autopairs.nvim-autopairs.enable = true;

        git.gitsigns.enable = true;

        filetree.neo-tree.enable = true;

        dashboard.dashboard-nvim.enable = true;

        binds.whichKey.enable = true;

        languages = {
          enableLSP = true;
          enableTreesitter = true;

          nix.enable = true;
          csharp.enable = true;
          nu.enable = true;
          clang.enable = true;
          lua.enable = true;
        };

        globals = {
          mapleader = " ";
          maplocalleader = " ";
        };

        options = {
          tabstop = 2;
          softtabstop = 2;
          expandtab = true;
          shiftwidth = 2;

          number = true;
          relativenumber = true;

          ignorecase = true;
          smartcase = true;
          hlsearch = true;
          inccommand = "split"; # Preview substitutions while typing

          mouse = "a";
          showmode = false; # Mode is in our statusline, we don't need to show it
          breakindent = true;
          undofile = true;
          cursorline = true;
          scrolloff = 15;
        };

        keymaps = [
          {
            key = "<Esc>";
            mode = "n";
            action = "<cmd>nohlsearch<CR>";
            desc = "Clear highlighted search";
          }
          {
            key = "[d";
            mode = "n";
            action = "vim.diagnostic.goto_prev";
            lua = true;
            desc = "Go to previous [D]iagnostic message";
          }
          {
            key = "]d";
            mode = "n";
            action = "vim.diagnostic.goto_next";
            lua = true;
            desc = "Go to next [D]iagnostic message";
          }
          {
            key = "<leader>e";
            mode = "n";
            action = "vim.diagnostic.open_float";
            lua = true;
            desc = "Show diagnostic [E]rror messages";
          }
          {
            key = "<leader>q";
            mode = "n";
            action = "vim.diagnostic.setloclist";
            lua = true;
            desc = "Open diagnostic [Q]uicfix list";
          }
          {
            key = "<C-d>";
            mode = "n";
            action = "<C-d>zz";
            desc = "Center screen when moving page down";
          }
          {
            key = "<C-u>";
            mode = "n";
            action = "<C-u>zz";
            desc = "Center screen when moving page up";
          }
        ];

        luaConfigPost = ''
          -- Highlight when yanking text
          vim.api.nvim_create_autocmd("TextYankPost", {
              desc = "Highlight when yanking (copying) text",
              group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
              callback = function()
              vim.highlight.on_yank()
          end,
        '';
      };
    };
    */

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
