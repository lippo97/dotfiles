return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5", 
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    config = function()
        require('telescope').setup({})

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
        vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = 'Find git files' })
        vim.keymap.set('n', '<leader>ht', builtin.help_tags, { desc = 'Help tags' })
    end
}
