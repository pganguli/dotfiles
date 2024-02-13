return {
  -- add moonfly
  {
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
    lazy = false,
    priority = 1000,
  },

  -- Configure LazyVim to load moonfly
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "moonfly",
    },
    install = {
      colorscheme = { "moonfly" },
    },
  },
}
