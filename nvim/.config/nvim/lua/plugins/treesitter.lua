return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    opts = {
      install_dir = vim.fn.stdpath("data") .. "/site",
    },
    config = function(_, opts)
      require("nvim-treesitter").setup(opts)
      local parsers = {
        "python", "lua", "vim", "vimdoc", "bash", "json",
        "c", "cpp", "go", "rust", "toml", "yaml", "make",
      }
      vim.defer_fn(function()
        require("nvim-treesitter").install(parsers)
      end, 500)
    end,
  },
}
