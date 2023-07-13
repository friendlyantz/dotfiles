local plugins = {
    -- {
    --     'tpope/vim-fugitive',
    -- },
    {
        'neovim/nvim-lspconfig',
        config = function ()
            require "plugins.configs.lspconfig"
            require "custom.configs.lspconfig"
        end,
    },
    {
        'ThePrimeagen/harpoon', lazy = false
    },
    {
        "github/copilot.vim", lazy = false,
        config = function ()
           vim.cmd("let g:copilot_assume_mapped = v:true")
        end

    },
    {
        "vim-crystal/vim-crystal",
         ft = "crystal",
         config = function()
           vim.g.crystal_auto_format = 1
         end
    },
}

return plugins
