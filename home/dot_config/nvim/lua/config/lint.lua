local lint = require("lint")

lint.linters_by_ft = {
  python = { "ruff" },
  sh = { "shellcheck" },
}

local lint_group = vim.api.nvim_create_augroup("lint-on-write", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  group = lint_group,
  callback = function()
    lint.try_lint()
  end,
})

vim.keymap.set("n", "<leader>ll", function()
  lint.try_lint()
end, { desc = "Lint buffer" })
