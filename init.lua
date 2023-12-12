require("set")
require("color")
require("keymap")
require("remap")

-- BEGIN
local plugins = {
  -- do not remove the colorscheme!
  "folke/tokyonight.nvim",
  "folke/neodev.nvim",

  -- Gruvbox theme
  { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true},

  -- Required for telescope
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "nvim-lua/plenary.nvim" },

  -- Telescope fuzzy finder, fd (find alternative prgram) and ripgrep also required
  { "nvim-telescope/telescope.nvim", tag = "0.1.5" },
  { "VonHeikemen/lsp-zero.nvim", branch = "v3.x"},

  -- LSP server managerment
  {"williamboman/mason.nvim"},
  {"williamboman/mason-lspconfig.nvim"},

  {"neovim/nvim-lspconfig"},
  {"hrsh7th/cmp-nvim-lsp"},
  {"hrsh7th/nvim-cmp"},
  {"L3MON4D3/LuaSnip"}
 }

-- Setup Lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- Run the lazy package manager setup
require("lazy").setup(plugins)

-- Setup theme
require("gruvbox").setup()

-- Set the colorscheme
vim.cmd("colorscheme gruvbox")

-- Telescope (Fuzzy search)
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})


-- neodev 
require("neodev").setup({ })

-- Automatic setup of LSP + autocompletion :) and snippers as well
local lsp_zero = require("lsp-zero")

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

-- Setup LSP server manager (who wants to manage that shit themseleves?)
require("mason").setup({})

-- Setup LSP servers 

-- BEGIN
-- LUA
require("lspconfig").lua_ls.setup({})
-- GO Lang
require("lspconfig").gopls.setup({})
-- END
