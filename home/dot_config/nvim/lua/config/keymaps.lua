local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })
map("n", "<C-t>", "<cmd>tabnew<cr>", { desc = "New tab" })
map("n", "<C-Tab>", "<cmd>tabnext<cr>", { desc = "Next tab" })
map("n", "<C-S-Tab>", "<cmd>tabprevious<cr>", { desc = "Previous tab" })
map("n", "<C-Right>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<C-Left>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })
map("n", "<F8>", "<cmd>cnext<cr>", { desc = "Next quickfix item" })
map("n", "<S-F8>", "<cmd>cprevious<cr>", { desc = "Previous quickfix item" })

for _, direction in ipairs({ "h", "j", "k", "l" }) do
  map("n", "<A-" .. direction .. ">", "<C-w>" .. direction, { desc = "Focus " .. direction .. " window" })
  map("i", "<A-" .. direction .. ">", "<C-\\><C-n><C-w>" .. direction, { desc = "Focus " .. direction .. " window" })
  map("t", "<A-" .. direction .. ">", "<C-\\><C-n><C-w>" .. direction, { desc = "Focus " .. direction .. " window" })
end

map("n", "<C-`>", "<cmd>terminal<cr>", { desc = "Open terminal" })
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Leave terminal mode" })
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], { desc = "Replace word under cursor" })
map("x", "//", [[y/\V<C-r>=escape(@",'/\')<cr><cr>]], { desc = "Search selection" })

map("n", "<leader>bo", function()
  local current = vim.api.nvim_get_current_buf()
  for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
    if buffer ~= current and vim.api.nvim_buf_is_loaded(buffer) then
      vim.api.nvim_buf_delete(buffer, {})
    end
  end
end, { desc = "Delete other buffers" })

if vim.g.neovide then
  vim.g.neovide_scale_factor = 1.0
  map("n", "<C-=>", function()
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1
  end, { desc = "Increase GUI scale" })
  map("n", "<C-->", function()
    vim.g.neovide_scale_factor = math.max(0.5, vim.g.neovide_scale_factor - 0.1)
  end, { desc = "Decrease GUI scale" })
  map("n", "<C-0>", function()
    vim.g.neovide_scale_factor = 1.0
  end, { desc = "Reset GUI scale" })
end
