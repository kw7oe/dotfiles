require'telescope'.setup {}

-- Map shortcuts for a few telescope pickers
vim.keymap.set('n', '<leader>t', '<cmd>Telescope<cr>', { desc = 'Telescope' })
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Files' })
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { desc = 'Buffers' })
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = 'Live Grep' })
-- vim.keymap.set('n', '<leader>e', '<cmd>Telescope file_browser<cr>', { desc = 'File Browser' })

vim.keymap.set('n', 'ghg', '<cmd>Telescope git_status<cr>', { desc = 'Git Status' })
vim.keymap.set('n', 'ghf', '<cmd>Telescope git_commits<cr>', { desc = 'Git History' })
vim.keymap.set('n', 'ghF', '<cmd>Telescope git_bcommits<cr>', { desc = 'Git File History' })
vim.keymap.set('n', 'gha', '<cmd>Telescope git_stash<cr>', { desc = 'Git Stashes' })
vim.keymap.set('n', 'ghs', '<cmd>Telescope git_branches<cr>', { desc = 'Git Branches' })
