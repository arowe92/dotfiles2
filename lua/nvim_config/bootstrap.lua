-- local ensure_packer = function()
--     local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.vim'
--     if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
--         vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
--         vim.cmd [[packadd packer.nvim]]
--         return true
--     end
--     return false
-- end
-- return ensure_packer
--
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
