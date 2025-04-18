return {

  "nvim-lualine/lualine.nvim",
  dependencies = {
    { "nvim-tree/nvim-web-devicons", opt = true  },
    "vimpostor/vim-tpipeline",
  },
  config = function ()
    require("lualine").setup { }

    -- https://github.com/vimpostor/vim-tpipeline/issues/53#issuecomment-2278349602
    if os.getenv('TMUX') then
      vim.defer_fn(function() vim.o.laststatus=0 end, 0)
    end
  end
}
