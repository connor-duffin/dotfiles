-- Line numbering
vim.opt.number = true
vim.opt.relativenumber = true

-- Syntax/filetype (Neovim normally enables these; kept for parity)
vim.cmd('filetype plugin on')
vim.cmd('syntax on')

-- Color column at 80
vim.opt.colorcolumn = "80"

-- Disable folding
vim.opt.foldenable = false

-- Tabs / indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

-- If you truly want zero automatic indentation, uncomment below:
-- vim.cmd('filetype indent off')
-- vim.opt.autoindent = false
-- vim.opt.smartindent = false
-- vim.opt.cindent = false

-- Persistent undo
vim.opt.undofile = true

-- Clipboard support
vim.opt.clipboard = "unnamedplus"

-- =========================================
-- Keymaps
-- =========================================
local map = vim.keymap.set
local silent = { silent = true }

-- Movement through wrapped lines
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })

-- Force quit
map('n', '<C-q>', ':q!<CR>', silent)

-- =============================
-- Plugin Management (lazy.nvim)
-- =============================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.notify("Installing lazy.nvim...", vim.log.levels.INFO)
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require('lazy').setup({
  -- Nvim tree (file tree explorer/browser)
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup()
      vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { silent = true })
    end
  },
  -- tmux integration
  { 
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
  -- Python syntax highlighting
  { 'vim-python/python-syntax' }
})

-- Python syntax plugin configuration
vim.g.python_highlight_all = 1

-- Don't line up function arguments under the opening bracket
vim.g.r_indent_align_args = 0
