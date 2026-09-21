local overseer = require("overseer")

overseer.setup({
  task_list = {
    direction = "bottom",
    min_height = 12,
    max_height = 24,
  },
})

local function register_task(workflow, name, command, tag, arguments)
  overseer.register_template({
    name = workflow .. ": " .. name,
    tags = { tag },
    builder = function()
      local cmd = { workflow .. "-workflow", command }
      vim.list_extend(cmd, arguments or {})
      return {
        cmd = cmd,
        components = {
          { "on_output_quickfix", open = false },
          "default",
        },
      }
    end,
  })
end

register_task("qmake", "configure", "configure", overseer.TAG.BUILD)
register_task("qmake", "build", "build", overseer.TAG.BUILD)
register_task("qmake", "clean", "clean", overseer.TAG.BUILD)
register_task("qmake", "clear", "clear", overseer.TAG.BUILD)
register_task("qmake", "rebuild", "rebuild", overseer.TAG.BUILD)
register_task("qmake", "compile database", "compdb", overseer.TAG.BUILD)
register_task("qmake", "lint", "lint", overseer.TAG.TEST)
register_task("qmake", "unit tests", "test", overseer.TAG.TEST, { "unit" })
register_task("qmake", "UGCS test list", "test", overseer.TAG.TEST, { "ugcs", "list" })
register_task("qmake", "UGCS HealthCheckExecutorTest", "test", overseer.TAG.TEST, { "ugcs", "HealthCheckExecutorTest" })
register_task("qmake", "run", "run", overseer.TAG.RUN)

register_task("cmake", "configure", "configure", overseer.TAG.BUILD)
register_task("cmake", "build", "build", overseer.TAG.BUILD)
register_task("cmake", "test", "test", overseer.TAG.TEST)
register_task("cmake", "clean", "clean", overseer.TAG.BUILD)
register_task("cmake", "clear", "clear", overseer.TAG.BUILD)
register_task("cmake", "rebuild", "rebuild", overseer.TAG.BUILD)

vim.keymap.set("n", "<leader>tr", "<cmd>OverseerRun<cr>", { desc = "Run task" })
vim.keymap.set("n", "<leader>tt", "<cmd>OverseerToggle<cr>", { desc = "Toggle task list" })
vim.keymap.set("n", "<leader>ta", "<cmd>OverseerTaskAction<cr>", { desc = "Task action" })
vim.keymap.set("n", "<leader>tb", function()
  local workflow
  if vim.system({ "qmake-workflow", "show" }, { text = true }):wait().code == 0 then
    workflow = "qmake"
  elseif vim.system({ "cmake-workflow", "show" }, { text = true }):wait().code == 0 then
    workflow = "cmake"
  else
    vim.notify("No qmake or CMake project found", vim.log.levels.ERROR)
    return
  end
  overseer.run_task({ name = workflow .. ": build" })
end, { desc = "Build current project" })
