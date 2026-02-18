return
{
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require('nightfox').setup({
        options = {
          transparent = true,
        }
      })
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    config = function()
      require('kanagawa').setup({
        transparent = true,
      })
    end,
  },
  {
	"rose-pine/neovim",
  lazy = false,
  priority = 1000,
	config = function()
    require("rose-pine").setup({
      styles = {
        transparency = true,
      }
    })
	end
  },
}
