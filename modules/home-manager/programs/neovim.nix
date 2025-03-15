{
  config,
  lib,
  ...
}: {
  options = {
    modules.programs.neovim.enable = lib.mkEnableOption "Layer-based, hyperextensible text editor";
  };

  config = lib.mkIf config.modules.programs.neovim.enable {
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

        languages = {
          enableLSP = true;
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;

          nix.enable = true;
          nix.extraDiagnostics.types = []; # Remove annoying deadnix warnings
          markdown.enable = true;
          csharp.enable = true;
          clang.enable = true;
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
          mappings = {
            findFiles = "<leader>sf";
            liveGrep = "<leader>sg";
            gitCommits = "<leader>svc";
            diagnostics = "<leader>sd";
          };
        };

        tabline = {
          nvimBufferline.enable = true;
        };

        binds = {
          whichKey.enable = true;
          cheatsheet.enable = true;
        };

        git = {
          enable = true;
          gitsigns.enable = true;
          gitsigns.codeActions.enable = false;
        };

        minimap = {
          codewindow.enable = true;
        };

        dashboard.dashboard-nvim = {
          enable = true;
        };

        notes = {
          todo-comments.enable = true;
        };

        filetree.neo-tree = {
          enable = true;
          setupOpts = {
            event_handlers = {
              event = "file_open_requested";
              handler = "require(neo-tree.command).execute({action = \"close\"})";
            };
          };
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
  };
}
