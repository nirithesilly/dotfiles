return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      format_on_save = {
        timeout_ms = 2000,
        lsp_format = "fallback",
      },
      formatters_by_ft = {
        python = { "ruff_format" },
        lua = { "stylua" },
        sh = { "shfmt" },
        cpp = { "clang_format" },
        c = { "clang_format" },
        go = { "gofmt" },
        rust = { "rustfmt" },
      },
    },
  },
}
