--[[ return {
    'shaunsingh/nord.nvim',
    priority = 1000,
    config = function(_, _opts) vim.cmd [[colorscheme nord\]\] end
} ]]
return {
    'folke/tokyonight.nvim',
    config = function()
        vim.cmd [[colorscheme tokyonight-night]]
    end
}
