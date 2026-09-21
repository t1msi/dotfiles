local overseer = require("overseer")

local function file_exists(path)
  return vim.uv.fs_stat(path) ~= nil
end

local function task(name, cmd, cwd, tag)
  return {
    name = name,
    tags = { tag },
    builder = function()
      return {
        cmd = cmd,
        cwd = cwd,
        components = {
          { "on_output_quickfix", open = false },
          "default",
        },
      }
    end,
  }
end

return {
  cache_key = function(search)
    return vim.fs.root(search.dir, ".git")
  end,
  generator = function(search)
    local root = vim.fs.root(search.dir, ".git")
    if not root then
      return "No Git project found"
    end

    local tasks = {}
    if file_exists(root .. "/bootstrap") and file_exists(root .. "/ansible/workstation.yml") then
      table.insert(tasks, task("dotfiles: bootstrap", { "./bootstrap" }, root, overseer.TAG.BUILD))
    end

    local python = root .. "/.venv/bin/python3"
    if file_exists(python) and file_exists(root .. "/main.py") then
      table.insert(tasks, task("python: run main.py", { python, "./main.py" }, root, overseer.TAG.RUN))
      if file_exists(root .. "/tests/tst_python_sdk.py") then
        table.insert(tasks, task("python: SDK smoke test", { python, "./tests/tst_python_sdk.py" }, root, overseer.TAG.TEST))
      end
    end

    local repeater_config = "./configs/aeroscout/repeater/config.yaml"
    local drone_config = "./configs/aeroscout/drone/config.yaml"
    if file_exists(root .. "/" .. repeater_config) and file_exists(root .. "/" .. drone_config) then
      table.insert(tasks, task("diagnostics: run repeater", {
        "./build/aeroscout-diagnostics",
        "--config",
        repeater_config,
        "--device",
        "repeater",
      }, root, overseer.TAG.RUN))
      table.insert(tasks, task("diagnostics: run drone", {
        "./build/aeroscout-diagnostics",
        "--config",
        drone_config,
        "--device",
        "drone",
        "--destination-ip",
        "127.0.0.1",
      }, root, overseer.TAG.RUN))
    end

    return tasks
  end,
}
