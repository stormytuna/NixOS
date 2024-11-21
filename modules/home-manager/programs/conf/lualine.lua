require("lualine").setup({
  options = {
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { "filename", "filesize" },
    lualine_x = {},
    lualine_y = {
      "encoding",
      {
        "fileformat",
        icons_enabled = true,
        symbols = {
          unix = "LF",
          dos = "CRLF",
          max = "CR",
        },
      },
      "filetype",
    },
    lualine_z = { "progress", "location" },
  },
  extensions = { "neo-tree" },
})
