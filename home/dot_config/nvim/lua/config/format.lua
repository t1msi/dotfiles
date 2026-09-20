local conform = require("conform")

conform.setup({
  default_format_opts = { lsp_format = "fallback" },
  formatters_by_ft = {
    c = { "clang_format" },
    cpp = { "clang_format" },
    python = { "ruff_format" },
    sh = { "shfmt" },
  },
  notify_no_formatters = false,
})

vim.keymap.set({ "n", "x" }, "<leader>f", function()
  conform.format({ async = true, lsp_format = "fallback" })
end, { desc = "Format buffer or selection" })
