return {
  -- add everforest
  {
    "neanias/everforest-nvim",
    version = false,
    name = "everforest",
    lazy = false,
    priority = 1000,
    config = {
      -- Controls the "hardness" of the background.
      background = "hard", -- Options are "soft", "medium" or "hard".
      -- The contrast of line numbers, indent lines, etc.
      ui_contrast = "high", -- Options are `"high"` or `"low"`.
    },
  },

  -- Configure LazyVim to load everforest
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "everforest",
    },
    install = {
      colorscheme = { "everforest" },
    },
  },
}
