-- Line numbering
vim.opt.number = true
vim.opt.relativenumber = true

-- Syntax/filetype (Neovim normally enables these; kept for parity)
vim.cmd('filetype plugin on')
vim.cmd('syntax on')

-- Color column at 80
vim.opt.colorcolumn = "80"

-- Grep program (consider switching to ripgrep later)
vim.opt.grepprg = "grep -nH $*"

-- LaTeX flavor
vim.g.tex_flavor = "latex"

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

-- GUI options (mostly relevant only in GUI clients; ignored in terminal)
vim.cmd('set guioptions-=m')
vim.cmd('set guioptions-=T')
vim.cmd('set guioptions-=r')

-- =========================================
-- Keymaps
-- =========================================
local map = vim.keymap.set
local silent = { silent = true }

-- NERDTree toggle (if still using NERDTree)
map('n', '<C-n>', ':NERDTreeToggle<CR>', silent)

-- Movement through wrapped lines
map('n', 'j', 'gj', { noremap = true })
map('n', 'k', 'gk', { noremap = true })

-- Tab navigation
map('n', 'L', 'gt', { noremap = true })
map('n', 'H', 'gT', { noremap = true })

-- Force quit
map('n', '<C-q>', ':q!<CR>', silent)

-- Window navigation
map('n', '<C-j>', '<C-W><C-j>', { noremap = true })
map('n', '<C-k>', '<C-W><C-k>', { noremap = true })
map('n', '<C-l>', '<C-W><C-l>', { noremap = true })
map('n', '<C-h>', '<C-W><C-h>', { noremap = true })

-- =========================================
-- Plugin Management (lazy.nvim example)
-- =========================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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
  -- Treesitter for syntax parsing
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { "lua", "python", "markdown", "markdown_inline", "r", "rnoweb", "yaml", "csv", "bash", "latex", "cpp" },
        highlight = { enable = true },
        indent = { enable = true },
      }
    end
  },
  -- R setup
  {
    "R-nvim/R.nvim",
     -- Only required if you also set defaults.lazy = true
    lazy = false
  },
  {
    "R-nvim/cmp-r",
    {
        "hrsh7th/nvim-cmp",
        config = function()
            require("cmp").setup({ sources = {{ name = "cmp_r" }}})
            require("cmp_r").setup({})
        end,
    },
  },
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
  -- Pretty flexoki theme
  { 'kepano/flexoki-neovim', name = 'flexoki',
    config = function()
      vim.cmd.colorscheme('flexoki')
    end
  },
  -- Web icons for pretty printing
  { "nvim-tree/nvim-web-devicons", opts = {} },
  -- Python syntax highlighting
  { 'vim-python/python-syntax' },
  -- Github Copilot
  { 'github/copilot.vim' }
})

-- Python syntax plugin configuration
vim.g.python_highlight_all = 1

-- =========================================
-- Optional extras (commented out)
-- =========================================
-- vim.opt.completeopt = { "menuone", "noselect" }

-- Use ripgrep if available
-- if vim.fn.executable('rg') == 1 then
--   vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"
-- end

-- Persistent undo (recommended)
-- vim.opt.undofile = true
