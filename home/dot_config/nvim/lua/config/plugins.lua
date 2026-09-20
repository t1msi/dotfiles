local function github(repository)
  return "https://github.com/" .. repository
end

vim.api.nvim_create_autocmd("PackChanged", {
  group = vim.api.nvim_create_augroup("plugin-update-hooks", { clear = true }),
  callback = function(event)
    if event.data.kind == "update" and event.data.spec.name == "nvim-treesitter" then
      vim.schedule(function()
        vim.cmd("TSUpdate")
      end)
    end
  end,
})

vim.pack.add({
  github("hrsh7th/cmp-buffer"),
  github("hrsh7th/cmp-nvim-lsp"),
  github("hrsh7th/cmp-path"),
  github("hrsh7th/nvim-cmp"),
  github("jnurmine/Zenburn"),
  github("mfussenegger/nvim-dap"),
  github("mfussenegger/nvim-lint"),
  github("neovim/nvim-lspconfig"),
  github("nvim-lua/plenary.nvim"),
  github("nvim-telescope/telescope.nvim"),
  { src = github("nvim-tree/nvim-tree.lua"), version = vim.version.range("1") },
  github("nvim-treesitter/nvim-treesitter"),
  github("stevearc/conform.nvim"),
  github("stevearc/overseer.nvim"),
  github("tpope/vim-fugitive"),
  github("echasnovski/mini.surround"),
}, { confirm = false, load = true })

require("config.ui")
require("config.completion")
require("config.treesitter")
require("config.lsp")
require("config.format")
require("config.lint")
require("config.dap")
require("config.tasks")
