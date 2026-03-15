return {
  -- Disable animated scrolling from snacks
  {
    "folke/snacks.nvim",
    opts = {
      scroll = { enabled = false },
    },
  },

  -- Disable LazyVim news notifications
  {
    "folke/snacks.nvim",
    opts = {
      notifier = {
        enabled = true,
      },
      dashboard = {
        preset = {
          header = false,
        },
      },
    },
  },
}
