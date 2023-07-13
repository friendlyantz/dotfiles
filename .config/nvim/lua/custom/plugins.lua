local plugins = {
    {
        'ThePrimeagen/harpoon', lazy = false
    },
    {
        "github/copilot.vim", lazy = false
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
