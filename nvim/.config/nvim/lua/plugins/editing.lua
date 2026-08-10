return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = { check_ts = true },
  },
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gc", mode = { "n", "v" }, "<Plug>(comment_toggle_linewise)", desc = "Comment toggle linewise" },
      { "gb", mode = { "n", "v" }, "<Plug>(comment_toggle_blockwise)", desc = "Comment toggle blockwise" },
    },
    opts = {},
  },
}
