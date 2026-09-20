local overseer = require("overseer")

overseer.setup({
  task_list = {
    direction = "bottom",
    min_height = 12,
    max_height = 24,
  },
})

local function register_qmake_task(name, command, tag)
  overseer.register_template({
    name = "qmake: " .. name,
    tags = { tag },
    builder = function()
      return {
        cmd = { "qmake-workflow", command },
        components = {
          { "on_output_quickfix", open = false },
          "default",
        },
      }
    end,
  })
end

register_qmake_task("configure", "configure", overseer.TAG.BUILD)
register_qmake_task("build", "build", overseer.TAG.BUILD)
register_qmake_task("compile database", "compdb", overseer.TAG.BUILD)
register_qmake_task("lint", "lint", overseer.TAG.TEST)
register_qmake_task("run", "run", overseer.TAG.RUN)

vim.keymap.set("n", "<leader>tr", "<cmd>OverseerRun<cr>", { desc = "Run task" })
vim.keymap.set("n", "<leader>tt", "<cmd>OverseerToggle<cr>", { desc = "Toggle task list" })
vim.keymap.set("n", "<leader>ta", "<cmd>OverseerTaskAction<cr>", { desc = "Task action" })
vim.keymap.set("n", "<leader>tb", function()
  overseer.run_task({ name = "qmake: build" })
end, { desc = "Build qmake project" })
