-- [[ Configure Treesitter ]] See `:help nvim-treesitter`

-- Prefer git instead of curl in order to improve connectivity in some environments
require("nvim-treesitter.install").prefer_git = true
require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
  },
})

-- There are additional nvim-treesitter modules that you can use to interact
-- with nvim-treesitter. You should go explore a few and see what interests you:
--
--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod

--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobje
