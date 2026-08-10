return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    opts = {
      install_dir = vim.fn.stdpath("data") .. "/site",
      ensure_installed = { "python", "lua", "vim", "vimdoc", "bash", "json" },
    },
  },
}
