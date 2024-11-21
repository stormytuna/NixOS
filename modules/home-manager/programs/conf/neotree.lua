require("neo-tree").setup({
  filesystem = {
    window = {
      mappings = {
        ["\\"] = "close_window",
      },
    },
  },
  event_handlers = {
    {
      event = "file_opened",
      handler = function()
        require("neo-tree.command").execute({ action = "close" })
      end,
    },
  },
})

vim.keymap.set("", "\\", ":Neotree reveal<CR>", { desc = "NeoTree reveal" })
