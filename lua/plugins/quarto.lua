return {
  {
    -- for lsp features in code cells / embedded code
    "jmbuhr/otter.nvim",
    dev = false,
    dependencies = {
      {
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
      },
    },
    opts = {
      verbose = {
        no_code_found = false,
      },
    },
  },

  {
    "quarto-dev/quarto-nvim",
    ft = { "quarto", "markdown" },
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
}

--require("lspconfig")["pyright"].setup({
--  on_attach = on_attach,
--  capabilities = capabilities,
--  settings = {
--    python = {
--      analysis = {
--        diagnosticSeverityOverrides = {
--          reportUnusedExpression = "none",
--        },
--      },
--    },
--  },
--})
