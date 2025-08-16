-- Key mappings for Ctrl+(hjkl) to switch between windows
vim.api.nvim_set_keymap(
    "n",
    "<C-l>",
    "<C-w>l",
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<C-h>",
    "<C-w>h",
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<C-j>",
    "<C-w>j",
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<C-k>",
    "<C-w>k",
    { noremap = true, silent = true }
)

-- Key mappings for Ctrl+PageDown and Ctrl+PageUp to cycle tabs
-- Normal mode mapping
vim.api.nvim_set_keymap(
    "n",
    "<C-PageDown>",
    ":tabnext<CR>",
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<C-PageUp>",
    ":tabprevious<CR>",
    { noremap = true, silent = true }
)

-- Insert mode mapping
vim.api.nvim_set_keymap(
    "i",
    "<C-PageDown>",
    "<Esc>:tabnext<CR>i",
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "i",
    "<C-PageUp>",
    "<Esc>:tabprevious<CR>i",
    { noremap = true, silent = true }
)

-- Visual mode mapping
vim.api.nvim_set_keymap(
    "v",
    "<C-PageDown>",
    "<Esc>:tabnext<CR>gv",
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "v",
    "<C-PageUp>",
    "<Esc>:tabprevious<CR>gv",
    { noremap = true, silent = true }
)

-- Command mode mapping
vim.api.nvim_set_keymap(
    "c",
    "<C-PageDown>",
    "<C-C>:tabnext<CR>",
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "c",
    "<C-PageUp>",
    "<C-C>:tabprevious<CR>",
    { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
    "t",
    "<C-PageDown>",
    "<C-\\><C-N>:tabnext<CR>",
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "t",
    "<C-PageUp>",
    "<C-\\><C-N>:tabprevious<CR>",
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>nt",
    "<:tabnew<CR>",
    { noremap = true, silent = true }
)

-- Inlay hints toggle with Ctrl+Alt+I
vim.api.nvim_set_keymap(
    "n",
    "<C-A-i>",
    ":lua require('nagar.config.helper').toggle_inlay_hints(0)<CR>",
    { noremap = true, silent = true, desc = "Toggle inlay hints" }
)
vim.api.nvim_set_keymap(
    "i",
    "<C-A-i>",
    "<Esc>:lua require('nagar.config.helper').toggle_inlay_hints(0)<CR>a",
    { noremap = true, silent = true, desc = "Toggle inlay hints" }
)
