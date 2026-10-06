-- nvim-treesitter `main` branch (the only one that supports Neovim 0.12+).
-- Needs `tree-sitter` CLI 0.26.1+, a C compiler, tar and curl on your PATH.
return {
   "nvim-treesitter/nvim-treesitter",
   branch = "main",
   build = ":TSUpdate",
   lazy = false, -- this plugin doesn't support lazy-loading
   config = function()
      local ts = require("nvim-treesitter")

      -- Same parsers as before; no-op if they're already installed
      ts.install({ "c", "lua", "java", "vim", "vimdoc", "query", "python" })

      local function start(buf, lang)
         return vim.api.nvim_buf_is_valid(buf) and pcall(vim.treesitter.start, buf, lang)
      end

      -- Turn on highlighting for every file, and install missing parsers
      -- automatically (replaces the old `highlight` and `auto_install` options)
      vim.api.nvim_create_autocmd("FileType", {
         callback = function(args)
            local buf = args.buf
            local lang = vim.treesitter.language.get_lang(args.match)
            if not lang then
               return
            end

            -- Works if a parser is already installed; otherwise fetch one
            if not start(buf, lang) and vim.tbl_contains(ts.get_available(), lang) then
               ts.install(lang):await(function(err)
                  if not err then
                     vim.schedule(function()
                        start(buf, lang)
                     end)
                  end
               end)
            end
         end,
      })
   end,
}

