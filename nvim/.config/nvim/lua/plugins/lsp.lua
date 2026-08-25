return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {
      ensure_installed = { "stylua", "shfmt" },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = { "pyright", "lua_ls", "clangd" },
      automatic_enable = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })

      for _, server in ipairs({ "gopls", "rust_analyzer" }) do
        if vim.fn.executable(server) == 1 then
          vim.lsp.enable(server)
        end
      end

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            diagnostics = { globals = { "vim" } },
          },
        },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufmap = function(mode, keys, fn, desc)
            vim.keymap.set(mode, keys, fn, { buffer = args.buf, desc = desc })
          end

          bufmap("n", "gd", vim.lsp.buf.definition, "Goto definition")
          bufmap("n", "gr", vim.lsp.buf.references, "References")
          bufmap("n", "K", vim.lsp.buf.hover, "Hover")
          bufmap("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
          bufmap("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
        end,
      })
    end,
  },
}
