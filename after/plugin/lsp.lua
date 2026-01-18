local lsp = require('lsp-zero').preset({})
local lspconfig = require('lspconfig')

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

--require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
--require('lspconfig').pyright.setup(lsp.pyright())
lspconfig.clangd.setup{}
lspconfig.lua_ls.setup{}

local servers = { 'clangd' }
for _, lsp in pairs(servers) do
   require('lspconfig')[lsp].setup {
      on_attach = on_attach,
      flags = {
         debounce_text_changes = 150,
      }
   }
end

lsp.setup()
