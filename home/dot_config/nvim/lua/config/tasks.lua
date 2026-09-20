local overseer = require("overseer")

overseer.setup({
  task_list = {
    direction = "bottom",
    min_height = 12,
    max_height = 24,
  },
})

vim.keymap.set("n", "<leader>tr", "<cmd>OverseerRun<cr>", { desc = "Run task" })
vim.keymap.set("n", "<leader>tt", "<cmd>OverseerToggle<cr>", { desc = "Toggle task list" })
vim.keymap.set("n", "<leader>ta", "<cmd>OverseerTaskAction<cr>", { desc = "Task action" })
