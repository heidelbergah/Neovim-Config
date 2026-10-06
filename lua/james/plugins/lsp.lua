-- LSP using Neovim's built-in vim.lsp.config / vim.lsp.enable (replaces lsp-zero).
-- Same servers, keymaps and completion behaviour as the old lsp-zero setup.
return {
   {
      "mason-org/mason-lspconfig.nvim",
      dependencies = {
         "mason-org/mason.nvim",
         "neovim/nvim-lspconfig", -- provides the default config for each server
         "hrsh7th/cmp-nvim-lsp",
      },
      lazy = false,
      config = function()
         -- Rounded borders on hover/signature/diagnostic popups (lsp-zero did this)
         vim.o.winborder = "rounded"
         vim.diagnostic.config({ severity_sort = true })

         -- Tell every server that nvim-cmp can handle completion
         vim.lsp.config("*", {
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
         })

         -- Keymaps, set only in buffers that have a language server attached
         vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
               local function map(mode, lhs, rhs)
                  vim.keymap.set(mode, lhs, rhs, { buffer = args.buf })
               end

               map("n", "K", vim.lsp.buf.hover)
               map("n", "gd", vim.lsp.buf.definition)
               map("n", "gD", vim.lsp.buf.declaration)
               map("n", "gi", vim.lsp.buf.implementation)
               map("n", "go", vim.lsp.buf.type_definition)
               map("n", "gr", vim.lsp.buf.references)
               map("n", "gs", vim.lsp.buf.signature_help)
               map("n", "gl", vim.diagnostic.open_float)
               map("n", "<F2>", vim.lsp.buf.rename)
               map({ "n", "x" }, "<F3>", function() vim.lsp.buf.format({ async = true }) end)
               map({ "n", "x" }, "<F4>", vim.lsp.buf.code_action)
               -- [d and ]d (previous/next diagnostic) are built into Neovim now
            end,
         })

         require("mason").setup()
         require("mason-lspconfig").setup({
            -- Installed through :Mason if missing, then started automatically
            ensure_installed = { "clangd", "lua_ls" },
         })

         -- Also start them if they're installed system-wide instead of via Mason
         vim.lsp.enable({ "clangd", "lua_ls" })
      end,
   },

   -- Autocompletion
   {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      dependencies = {
         "hrsh7th/cmp-nvim-lsp",
         "L3MON4D3/LuaSnip",
      },
      config = function()
         local cmp = require("cmp")
         local select = { behavior = cmp.SelectBehavior.Select }

         local function next_or_open()
            if cmp.visible() then cmp.select_next_item(select) else cmp.complete() end
         end
         local function prev_or_open()
            if cmp.visible() then cmp.select_prev_item(select) else cmp.complete() end
         end

         cmp.setup({
            snippet = {
               expand = function(args)
                  require("luasnip").lsp_expand(args.body)
               end,
            },
            sources = {
               { name = "nvim_lsp" },
            },
            mapping = {
               ["<C-y>"] = cmp.mapping.confirm({ select = true }),
               ["<C-e>"] = cmp.mapping.abort(),
               ["<C-n>"] = cmp.mapping(next_or_open),
               ["<C-p>"] = cmp.mapping(prev_or_open),
               ["<Down>"] = cmp.mapping.select_next_item(select),
               ["<Up>"] = cmp.mapping.select_prev_item(select),
               ["<C-d>"] = cmp.mapping.scroll_docs(4),
               ["<C-u>"] = cmp.mapping.scroll_docs(-4),
            },
            window = {
               documentation = { max_height = 15, max_width = 60 },
            },
            formatting = {
               fields = { "abbr", "menu", "kind" },
               format = function(entry, item)
                  item.menu = entry.source.name == "nvim_lsp" and "[LSP]"
                     or ("[" .. entry.source.name .. "]")
                  return item
               end,
            },
         })
      end,
   },
}

