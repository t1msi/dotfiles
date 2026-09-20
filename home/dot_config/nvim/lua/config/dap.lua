local dap = require("dap")

dap.adapters.debugpy = {
  type = "executable",
  command = "debugpy-adapter",
}
dap.configurations.python = {
  {
    type = "debugpy",
    request = "launch",
    name = "Launch current file",
    program = "${file}",
    pythonPath = function()
      return vim.fn.exepath("python3")
    end,
  },
}

dap.adapters.lldb = function(callback)
  local command = vim.fn.exepath("lldb-dap")
  if command == "" then
    command = vim.fn.exepath("lldb-vscode")
  end
  if command == "" then
    local versioned_commands = vim.list_extend(
      vim.fn.glob("/usr/bin/lldb-dap-*", false, true),
      vim.fn.glob("/usr/bin/lldb-vscode-*", false, true)
    )
    table.sort(versioned_commands)
    command = versioned_commands[#versioned_commands] or ""
  end
  if command == "" then
    vim.notify("Install lldb-dap or lldb-vscode to debug C/C++", vim.log.levels.ERROR)
    return
  end
  callback({ type = "executable", command = command, name = "lldb" })
end

local cpp_configuration = {
  type = "lldb",
  request = "launch",
  name = "Launch executable",
  cwd = "${workspaceFolder}",
  stopOnEntry = false,
  program = function()
    return vim.fn.input({
      prompt = "Executable: ",
      default = vim.fn.getcwd() .. "/staging/Course",
      completion = "file",
    })
  end,
}
dap.configurations.c = { cpp_configuration }
dap.configurations.cpp = { cpp_configuration }

vim.fn.sign_define("DapBreakpoint", { text = "B", texthl = "DiagnosticError" })
vim.fn.sign_define("DapStopped", { text = ">", texthl = "DiagnosticWarn", linehl = "Visual" })

vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug continue" })
vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug step over" })
vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug step into" })
vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug step out" })
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "Toggle debug REPL" })
vim.keymap.set({ "n", "x" }, "<leader>dh", function()
  require("dap.ui.widgets").hover()
end, { desc = "Debug value" })
vim.keymap.set("n", "<leader>ds", function()
  local widgets = require("dap.ui.widgets")
  widgets.centered_float(widgets.scopes)
end, { desc = "Debug scopes" })
