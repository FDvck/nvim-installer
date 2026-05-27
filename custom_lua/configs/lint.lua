local lint = require("lint")

lint.linters_by_ft = {
  python = { "pylint" },
  sh = { "shellcheck" },
  html = { "htmlhint" },
  css = { "stylelint" },
}

-- Trigger linting automatically on save
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
