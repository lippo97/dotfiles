return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require('rose-pine').setup({ })
            -- vim.cmd('colorscheme rose-pine')
        end
    }, {
        "folke/tokyonight.nvim",
        config = function()
            require('tokyonight').setup({
                style = "storm"
            })
            vim.cmd('colorscheme tokyonight')
        end
    }
}
