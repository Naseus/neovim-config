-- important locals
local coq = require('coq')
local telescope = require('telescope')
local telFunctions = require('telescope.builtin')
local tresitter = require('nvim-treesitter')

-- COQ
vim.cmd('COQnow -s')
vim.cmd("let g:coq_settings = { 'display.icons.mode': 'none' }")

-- Setup for LSP
local util = require("lspconfig/util")
local lspconfig = require("lspconfig")
local lspinstall = require("nvim-lsp-installer").setup({
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})

local my_on_attach = function(client, target)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
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
    -- show errors
    vim.keymap.set('n', '<leader>k', vim.diagnostics.open_float)
    -- LSP telescope
    vim.keymap.set('n', '<leader>fe', telFunctions.diagnostics)
end

local go_on_attach = function (client, target)
        vim.bo.shiftwidth = 4
        vim.bo.tabstop = 4
        vim.bo.expandtab = false
        my_on_attach(client, target)
end

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver', 'gopls', 'sumneko_lua' , 'html', 'svelte'}
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup(coq.lsp_ensure_capabilities({
        on_attach = my_on_attach,
        capabilities = capabilities,
    }))
end

lspconfig.sumneko_lua.setup {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
}

lspconfig.gopls.setup(coq.lsp_ensure_capabilities({
    on_attach = go_on_attach,
    cmd = {"gopls", "serve"},
    filetypes = {"go", "gomod"},
    root_dir = util.root_pattern("go.work", "go.mod", ".git"),
    settings = {
        gopls = {
            analyses ={
                unusedparams = true,
            },
            staticchecks = true,
        },
    },
    capabilities = capabilities,
}))

-- Treesitter
require('nvim-treesitter.configs').setup({
    ensure_installed = {"go", "c", "javascript", "typescript", "svelte"},
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
    },
    autotag = {
        enable = true,

    }
})
-- Telescope
vim.keymap.set('n', '<leader>ff', telFunctions.find_files)
vim.keymap.set('n', '<leader>fb', telFunctions.buffers)
vim.keymap.set('n', '<leader>fh', telFunctions.help_tags)
vim.keymap.set('n', '<leader>fg', telFunctions.live_grep)

-- BarBar tabs
require 'bufferline'.setup {
    -- Enable/disable animations
    animation = true,
    auto_hide = false,
    tabpages = true,
    closable = false,
    clickable = true,
    icons = 'numbers',
    -- Configure icons on the bufferline.
    icon_separator_active = '▎',
    icon_separator_inactive = '▎',
    icon_close_tab = 'x',
    icon_pinned = '!',
    insert_at_end = true,

    maximum_padding = 1,
    maximum_length = 30,

    -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
    -- where X is the buffer number. But only a static string is accepted here.
    no_name_title = nil,
}

local opts = { noremap = true, silent = true }

-- Move to previous/next
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferPrevious<CR>', opts)
vim.keymap.set('n', '<Tab>', '<Cmd>BufferNext<CR>', opts)
vim.keymap.set('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
vim.keymap.set('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
-- Goto buffer in position...
vim.keymap.set('n', '<leader>1', '<Cmd>BufferGoto 1<CR>', opts)
vim.keymap.set('n', '<leader>2', '<Cmd>BufferGoto 2<CR>', opts)
vim.keymap.set('n', '<leader>3', '<Cmd>BufferGoto 3<CR>', opts)
vim.keymap.set('n', '<leader>4', '<Cmd>BufferGoto 4<CR>', opts)
vim.keymap.set('n', '<leader>5', '<Cmd>BufferGoto 5<CR>', opts)
vim.keymap.set('n', '<leader>6', '<Cmd>BufferGoto 6<CR>', opts)
vim.keymap.set('n', '<leader>7', '<Cmd>BufferGoto 7<CR>', opts)
vim.keymap.set('n', '<leader>8', '<Cmd>BufferGoto 8<CR>', opts)
vim.keymap.set('n', '<leader>9', '<Cmd>BufferGoto 9<CR>', opts)
vim.keymap.set('n', '<leader>0', '<Cmd>BufferLast<CR>', opts)
-- Pin/unpin buffer
vim.keymap.set('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
-- Close buffer
vim.keymap.set('n', '<A-c>', '<Cmd>bd<CR>', opts)
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- Magic buffer-picking mode
vim.keymap.set('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)
-- Sort automatically by...
vim.keymap.set('n', '<leader>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
vim.keymap.set('n', '<leader>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
vim.keymap.set('n', '<leader>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
vim.keymap.set('n', '<leader>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)
