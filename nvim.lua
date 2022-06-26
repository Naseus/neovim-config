-- important locals
local coq = require('coq')
local telescope = require('telescope')
local telFunctions = require('telescope.builtin')
-- Setup for LSP
-- COQ
vim.cmd('COQnow -s')
vim.cmd("let g:coq_settings = { 'display.icons.mode': 'none' }")

-- Lspconfig
local lspconfig = require('lspconfig')
local lspinstall = require("nvim-lsp-installer").setup({
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver' }
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup(coq.lsp_ensure_capabilities( {
    on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
        local bufopts = { noremap=true, silent=true, buffer=bufnr }
        -- LSP Keymappings
        -- jumps
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
        -- formatting
        vim.keymap.set('n', '<leader>c', vim.lsp.buf.formatting, bufopts)
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
        -- intelligent rename
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
        -- code actions
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
        -- telescope errors
        vim.keymap.set('n', '<leader>fe', telFunctions.diagnostics)
    end,
    capabilities = capabilities,
  }))
end

-- Treesitter
require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
})

-- Telescope
vim.keymap.set('n', '<leader>ff', telFunctions.find_files)
vim.keymap.set('n', '<leader>fb', telFunctions.buffers)
vim.keymap.set('n', '<leader>fh', telFunctions.help_tags)
