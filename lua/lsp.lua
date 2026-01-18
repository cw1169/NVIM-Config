-- 1. Setup Mason
require("mason").setup()
require("mason-lspconfig").setup({
    -- Automatically install these if they are missing
    ensure_installed = { "lua_ls", "jdtls", "clangd" },
})

local lspconfig = require('lspconfig')

-- 2. Capabilities for blink.cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
if pcall(require, "blink.cmp") then
    capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)
end

-- 3. Common Keybindings
local on_attach = function(_, bufnr)
    local nmap = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
    end

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gr', vim.lsp.buf.references, '[G]oto [R]eferences')
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
end

-- 4. Server Specific Configurations

-- LUA
lspconfig.lua_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = { globals = { 'vim' } },
            workspace = { checkThirdParty = false },
        },
    },
})

-- C / C++ (clangd)
lspconfig.clangd.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    -- clangd requires specific offsetEncoding to work without warnings
    capabilities = vim.tbl_deep_extend('force', capabilities, {
        offsetEncoding = { 'utf-16' },
    }),
})

-- JAVA (jdtls)
lspconfig.jdtls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})
