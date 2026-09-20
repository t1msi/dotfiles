local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("*", {
  capabilities = capabilities,
  root_markers = { ".git" },
})

vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--compile-commands-dir=" .. (vim.env.QMAKE_BUILD_DIR or "build"),
  },
})

vim.lsp.config("basedpyright", {
  settings = {
    basedpyright = {
      analysis = { diagnosticMode = "openFilesOnly" },
    },
  },
})

vim.lsp.config("neocmake", {
  capabilities = capabilities,
})

vim.lsp.enable({ "ansiblels", "basedpyright", "bashls", "clangd", "neocmake", "sqlls", "yamlls" })

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-keymaps", { clear = true }),
  callback = function(event)
    local function map(keys, action, description)
      vim.keymap.set("n", keys, action, { buffer = event.buf, desc = description })
    end

    map("gd", vim.lsp.buf.definition, "Go to definition")
    map("gD", vim.lsp.buf.declaration, "Go to declaration")
    map("gi", vim.lsp.buf.implementation, "Go to implementation")
    map("gr", vim.lsp.buf.references, "List references")
    map("K", vim.lsp.buf.hover, "Show hover information")
    map("<C-k>", vim.lsp.buf.signature_help, "Show signature help")
    map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
    vim.keymap.set({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = event.buf, desc = "Code action" })

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method("textDocument/inlayHint", event.buf) then
      vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
    end
  end,
})

vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Previous diagnostic" })
vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostics to location list" })
vim.keymap.set("n", "<F4>", "<cmd>ClangdSwitchSourceHeader<cr>", { desc = "Switch source/header" })
