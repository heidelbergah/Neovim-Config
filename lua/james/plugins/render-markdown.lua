return {
   {
      "MeanderingProgrammer/render-markdown.nvim",
      dependencies = {
         "nvim-treesitter/nvim-treesitter",
         "nvim-tree/nvim-web-devicons", -- or "nvim-mini/mini.icons"
      },
      ft = { "markdown", "vimwiki" }, -- only load for these filetypes
      opts = {
         file_types = { "markdown", "vimwiki" },
      },
      config = function(_, opts)
         -- vimwiki changes the filetype, so tell treesitter to parse it as markdown
         vim.treesitter.language.register("markdown", "vimwiki")
         require("render-markdown").setup(opts)
      end,
   },
}

