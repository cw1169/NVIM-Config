-- 1. Basic Settings
require('options')
require('keymaps')
require('colorscheme')

-- 2. Load the Plugin Manager
-- We use 'config.lazy' because that is where your bootstrap code is located
require('lazy-config')

-- 3. Load your LSP configurations last
-- This ensures 'mason' and 'lspconfig' are ready before your lsp.lua runs
require('lsp')

-- 4. Final adjustments
vim.cmd("filetype plugin indent on")
