vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.cmd [[
   let g:cmake_link_compile_commands = 1
   ]]

vim.keymap.set("n", "<leader>cg", ":CMakeGenerate<CR>")
vim.keymap.set("n", "<leader>cb", ":CMakeBuild<CR>")
vim.keymap.set("n", "<leader>cc", ":CMakeClose<CR>")
