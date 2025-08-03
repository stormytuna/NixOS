{lib, ...}: {
  programs.nvf = {
    enable = true;
    settings.vim = {
      spellcheck.enable = true;

      globals = {
        mapleader = " ";
        maplocalleader = " ";
      };

      options = {
        tabstop = 2;
        softtabstop = 2;
        expandtab = true;
        shiftwidth = 2;
        clipboard = "unnamedplus";
      };

      lsp = {
        enable = true;
        formatOnSave = true;
        lightbulb.enable = true;
        trouble.enable = true;
        lspSignature.enable = true;
        nvim-docs-view.enable = true;

        mappings = {
          hover = "<C-Space>";
          signatureHelp = "<C-S-Space>";
        };
      };

      autocomplete.nvim-cmp = {
        enable = true;
        sourcePlugins = ["cmp-path"];
        setupOpts.enabled = lib.generators.mkLuaInline ''
          function()
            local disabled = false
            disabled = disabled or (vim.api.nvim_get_option_value('buftype', { buf = 0 }) == 'prompt')
            disabled = disabled or (vim.fn.reg_recording() ~= "")
            disabled = disabled or (vim.fn.reg_executing() ~= "")
            disabled = disabled or require('cmp.config.context').in_treesitter_capture('comment')
            return not disabled
          end
        '';
      };

      snippets = {
        luasnip.enable = true;
      };

      languages = {
        enableFormat = true;
        enableTreesitter = true;
        enableExtraDiagnostics = true;

        clang.enable = true;
        csharp.enable = true;
        markdown.enable = true;
        nix.enable = true;
        nix.extraDiagnostics.types = []; # Remove annoying deadnix warnings
        nu.enable = true;
      };

      debugger = {
        nvim-dap = {
          enable = true;
          ui.enable = true;
        };
      };

      statusline.lualine.enable = true;

      autopairs.nvim-autopairs.enable = true;

      telescope = {
        enable = true;
      };

      tabline = {
        nvimBufferline.enable = true;
      };

      binds = {
        whichKey.enable = true;
        cheatsheet.enable = true;
      };

      utility.motion.leap = {
        enable = true;
      };

      git = {
        enable = true;
        gitsigns.enable = true;
        gitsigns.codeActions.enable = false;
      };

      dashboard.dashboard-nvim = {
        enable = true;
      };

      notes = {
        todo-comments.enable = true;
      };

      filetree.neo-tree = {
        enable = true;
        setupOpts.filesystem.hijack_netrw_behavior = "disabled"; # Don't open when launching nvim with directory
      };

      maps.normal."\\" = {
        desc = "Toggle Neotree";
        action = "<cmd>Neotree toggle reveal<cr>";
      };

      projects.project-nvim = {
        enable = true;
        setupOpts = {
          show_hidden = true;
          silent_chdir = false;
        };
      };

      comments = {
        comment-nvim.enable = true;
      };

      presence = {
        neocord.enable = true;
      };

      visuals = {
        nvim-web-devicons.enable = true;
        nvim-cursorline.enable = true;
        fidget-nvim.enable = true;
        highlight-undo.enable = true;
        indent-blankline.enable = true;
      };

      ui = {
        borders.enable = true;
        noice.enable = true;
        colorizer.enable = true;
        illuminate.enable = true;
        breadcrumbs = {
          enable = true;
          navbuddy.enable = true;
        };
        smartcolumn = {
          enable = true;
          setupOpts.custom_colorcolumn = {
            nix = "110";
          };
        };
        fastaction.enable = true;
      };
    };
  };
}
