local fn = vim.fn

-- Install packer if it is not installed
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim",
                                  install_path})
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Reload packer whenever this file is changed
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Using protected calls to prevent errors 
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    vim.notify("Failed to require packer.")
    return
end

-- Use popup display for packer window
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({
                border = "rounded"
            })
        end
    }
})

return packer.startup(function(use)

    use("wbthomason/packer.nvim")           -- Manage packer
    use("nvim-lua/plenary.nvim")            -- Useful lua functions used by lots of plugins

    use("vim-airline/vim-airline")
    use("vim-airline/vim-airline-themes")

    use('arcticicestudio/nord-vim')
    use('ryanoasis/vim-devicons')


    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
