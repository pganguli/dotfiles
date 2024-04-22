return {
  -- extend the default nvim-treesitter config
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.auto_install = true
      vim.list_extend(opts.ensure_installed, {
        "html",
      })
    end,
  },
}
