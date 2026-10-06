return {
   "theprimeagen/harpoon",
   dependencies = { "nvim-lua/plenary.nvim" },
   keys = {
      { "<leader>a", function() require("harpoon.mark").add_file() end },
      { "<C-e>", function() require("harpoon.ui").toggle_quick_menu() end },

      { "<C-h>", function() require("harpoon.ui").nav_file(1) end },
      -- File 2 was on <C-t> in the old config, but NERDTree's <C-t> always
      -- overrode it. Pick a free key here if you want it back.
      -- { "<C-?>", function() require("harpoon.ui").nav_file(2) end },
      { "<C-n>", function() require("harpoon.ui").nav_file(3) end },
      { "<C-s>", function() require("harpoon.ui").nav_file(4) end },
   },
}
