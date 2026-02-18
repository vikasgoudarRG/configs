return
{
  'nvim-telescope/telescope.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'BurntSushi/ripgrep',
    'nvim-tree/nvim-web-devicons',
    'andrew-george/telescope-themes',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  config = function()
    local builtin = require('telescope.builtin')
    local actions = require('telescope.actions')
    local telescope = require('telescope')

    telescope.load_extension("fzf")
    telescope.load_extension("themes")

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
          },
        },
      },
      extensions = {
        themes = {
          enable_previewer = true,
          enable_live_preview = true,
          persist = {
            enabled = true,
            path = vim.fn.stdpath("config") .. "/lua/colorscheme.lua",
          },
        },
      },
    })
    -- Disables the default 'p' action if you only press leader + p
    vim.keymap.set("n", "<leader>p", "<nop>", { desc = "Prefix for project commands" })
    vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>pgf', builtin.git_files, { desc = 'Telescope find git files' })
    vim.keymap.set('n', '<leader>plg', builtin.live_grep, { desc = 'Telescope live grep' })
    vim.keymap.set({ 'n', 'x' }, '<leader>psg', builtin.grep_string, { desc = 'Telescope string grep' })
    vim.keymap.set('n', '<leader>pcf', function()
      builtin.find_files
      { cwd = vim.fn.stdpath("config") }
    end, { desc = 'Open neovim root config folder' })

    vim.keymap.set("n", "<leader>ths", "<cmd>Telescope themes<CR>",
      { noremap = true, silent = true, desc = "Theme Switcher" })
  end,
}
