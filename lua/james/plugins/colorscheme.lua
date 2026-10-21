-- Highlight groups that should show the terminal's (transparent) background
local transparent_groups = {
   -- Editor windows (NormalNC = a window that isn't focused, e.g. behind Telescope)
   "Normal",
   "NormalNC",
   "EndOfBuffer",
   "SignColumn",

   -- Popups (hover, diagnostics, completion docs)
   "NormalFloat",
   "FloatBorder",
   "FloatTitle",

   -- Autocomplete menu (PmenuSel, the selected item, keeps its colour)
   "Pmenu",
   "PmenuSbar",
   "PmenuKind",
   "PmenuExtra",

   -- Telescope
   "TelescopeNormal",
   "TelescopeBorder",
   "TelescopeTitle",
   "TelescopePromptNormal",
   "TelescopePromptBorder",
   "TelescopePromptTitle",
   "TelescopeResultsNormal",
   "TelescopeResultsBorder",
   "TelescopeResultsTitle",
   "TelescopePreviewNormal",
   "TelescopePreviewBorder",
   "TelescopePreviewTitle",
}

-- Remove the background from those groups, keeping their text colours
local function make_transparent()
   for _, name in ipairs(transparent_groups) do
      local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
      hl.bg = nil
      hl.ctermbg = nil
      vim.api.nvim_set_hl(0, name, hl)
   end
end

-- Re-apply after any colorscheme loads, so switching themes stays transparent
vim.api.nvim_create_autocmd("ColorScheme", { callback = make_transparent })

function ColorMyPencils(color)
   color = color or "ashen" -- terafox, gruvbox, everforest, ashen
   vim.cmd.colorscheme(color) -- the autocmd above makes it transparent
end

return {
   {
      "neanias/everforest-nvim",
      lazy = false,
      priority = 1000, -- load before everything else
      config = function()
         require("everforest").setup({
            -- everforest's own transparency setting, on top of the list above
            transparent_background_level = 1,
         })
         ColorMyPencils()
      end,
   },

   -- The others load automatically when you switch to them,
   -- e.g. :lua ColorMyPencils("gruvbox")
   { "ellisonleao/gruvbox.nvim", lazy = true },
   { "EdenEast/nightfox.nvim", lazy = true },
      { "EdenEast/nightfox.nvim", lazy = true },
   {
      "ficd0/ashen.nvim",
      lazy = true,
      opts = {
         transparent = true, -- ashen's own transparency, like everforest's
      },
   },
}

