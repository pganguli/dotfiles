return {
  -- change indent-blankline config
  {
    "lukas-reineke/indent-blankline.nvim",
    -- opts will be merged with the parent spec
    opts = {
      scope = { enabled = true, highlight = "Title" },
      indent = { highlight = { "ModeMsg", "NonText" } },
    },
  },
}
