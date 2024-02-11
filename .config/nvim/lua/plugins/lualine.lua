return {
  -- return new options to override all the defaults
  {
    "nvim-lualine/lualine.nvim",
    enabled = false,
    event = "VeryLazy",
    opts = function()
      vim.o.laststatus = vim.g.lualine_laststatus

      return {
        options = {
          theme = "auto",
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
          section_separators = "",
          component_separators = "",
        },
        sections = {
          lualine_a = {},
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = {
            {
              "buffers",
              buffers_color = {
                inactive = "NonText",
              },
            },
          },
          lualine_x = {
            { "selectioncount" },
            {
              "encoding",
              fmt = function(name)
                return "[" .. name
              end,
              padding = { left = 0, right = 1 },
            },
            {
              "fileformat",
              symbols = { unix = "LF", dos = "CR LF", mac = "CR" },
              padding = 0,
            },
            {
              "filetype",
              icons_enabled = false,
              fmt = function(name)
                return name .. "]"
              end,
              padding = { left = 1, right = 0 },
            },
          },
          lualine_y = {
            { "location", padding = { left = 1, right = 0 } },
            { "progress", padding = { left = 1, right = 0 } },
            { "%L", padding = { left = 1, right = 1 } },
          },
          lualine_z = {},
        },
        extensions = { "neo-tree", "lazy" },
      }
    end,
  },
}
