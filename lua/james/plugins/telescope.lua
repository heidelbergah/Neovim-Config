return {
   "nvim-telescope/telescope.nvim",
   -- 0.2.x works with the new nvim-treesitter; 0.1.x does not
   version = "^0.2.0",
   dependencies = { "nvim-lua/plenary.nvim" },
   keys = {
      { "<leader>ff", function() require("telescope.builtin").find_files() end },
      { "<C-p>", function() require("telescope.builtin").git_files() end },
      {
         "<leader>fs",
         function()
            require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
         end,
      },
   },
}

