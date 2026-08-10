return {
  {
    "stevearc/oil.nvim",
    lazy = false,
    keys = {
      { "<leader>e", "<cmd>Oil<CR>", desc = "Open file manager" },
    },
    opts = {
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
      },
    },
  },
}
