vim.api.nvim_set_keymap('n', "<leader>ft", ":FloatermNew --name=myfloat --height=0.8 --width=0.7 --autoclose=2 fish <CR>", {})
vim.api.nvim_set_keymap('n', "t", ":FloatermToggle myfloat<CR>", {})

