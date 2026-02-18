return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function() 
    require("todo-comments").setup({})

    vim.keymap.set("n", "<leader>pt", "<cmd>TodoTelescope<cr>", { desc = "Find Todos in Telescope" })
  end,
}
    -- PERF: 
    -- HACK:
    -- TODO:
    -- NOTE:
    -- FIX:
    -- WARNING
