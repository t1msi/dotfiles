local parsers = {
  "bash",
  "c",
  "cmake",
  "cpp",
  "json",
  "lua",
  "make",
  "markdown",
  "markdown_inline",
  "python",
  "pkl",
  "qmljs",
  "rust",
  "sql",
  "vim",
  "vimdoc",
  "yaml",
}

vim.filetype.add({
  pattern = {
    [".*%.pri"] = { "qmake", { priority = 10000 } },
    [".*%.prf"] = { "qmake", { priority = 10000 } },
    [".*%.pro"] = { "qmake", { priority = 10000 } },
  },
})
vim.treesitter.language.register("make", "qmake")
vim.treesitter.language.register("qmljs", { "qml", "qmljs" })

require("nvim-treesitter").setup({})

if vim.fn.executable("tree-sitter") == 1 then
  require("nvim-treesitter").install(parsers)
else
  vim.notify_once("tree-sitter CLI is unavailable; parsers cannot be installed", vim.log.levels.WARN)
end

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
  pattern = {
    "bash",
    "c",
    "cmake",
    "cpp",
    "json",
    "lua",
    "make",
    "markdown",
    "pkl",
    "python",
    "qmake",
    "qml",
    "qmljs",
    "rust",
    "sh",
    "sql",
    "vim",
    "yaml",
  },
  callback = function(event)
    if pcall(vim.treesitter.start, event.buf) then
      vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
