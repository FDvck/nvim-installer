return {
  -- Formatter plugin
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- ==========================================================
  -- MASON: Auto-instalación de LSPs, Linters y Formatters
  -- ==========================================================
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "bash-language-server",
        "black",
        "css-lsp",
        "html-lsp",
        "htmlhint",
        "prettier",
        "pylint",
        "pyright",
        "shellcheck",
        "shfmt",
        "stylelint",
      },
    },
  },
  
  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- Linter plugin (Nvim-lint)
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "configs.lint"
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc",
        "html", "css",
        "python", "bash",
      },
    },
  },
}
