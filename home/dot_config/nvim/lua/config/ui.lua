local telescope = require("telescope")

telescope.setup({
  pickers = {
    find_files = { theme = "dropdown" },
  },
})

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help" })
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Find diagnostics" })

require("nvim-tree").setup({
  actions = { open_file = { quit_on_open = false } },
  renderer = { group_empty = true },
  view = { width = 34 },
})
vim.keymap.set("n", "<A-e>", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file tree" })

require("mini.surround").setup()

vim.cmd.colorscheme("zenburn")
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#5b605e", bg = "#3f3f3f" })
