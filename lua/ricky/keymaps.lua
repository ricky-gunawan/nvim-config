local opts = { noremap = true, silent = true }

--Remap space as leader key
vim.keymap.set("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

------------ Modes ------------------
--  normal_mode = "n",
--  insert_mode = "i",
--  visual_mode = "v",
--  visual_block_mode = "x",
--  term_mode = "t",
--  command_mode = "c",
-------------------------------------

-- ----------------------- windows -----------------------------
-- -------------------------------------------------------------
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

-- resize window
vim.keymap.set("n", "<A-h>", "<cmd>vertical resize -5<CR>", opts)
vim.keymap.set("n", "<A-j>", "<cmd>resize -5<CR>", opts)
vim.keymap.set("n", "<A-k>", "<cmd>resize +5<CR>", opts)
vim.keymap.set("n", "<A-l>", "<cmd>vertical resize +5<CR>", opts)

-- new split window
vim.keymap.set({ "n", "v" }, "<leader>vp", "<cmd>vsp<CR>", opts)
vim.keymap.set({ "n", "v" }, "<leader>sp", "<cmd>sp<CR>", opts)

-- Vertical motions
vim.keymap.set({ "n", "v" }, "<C-A-j>", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set({ "n", "v" }, "<C-A-k>", ":m '<-2<CR>gv=gv", opts)
vim.keymap.set("n", "<leader>o", "o<esc>", opts)

-- Delete, Copy and Paste
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
vim.keymap.set({ "n", "v" }, "<leader>p", "\"_dP")

-- Highlighting
vim.keymap.set("n", "<esc>", "<cmd>noh<CR>")
