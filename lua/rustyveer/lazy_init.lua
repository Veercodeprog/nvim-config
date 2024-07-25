local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = "rustyveer.lazy",
	change_detection = { notify = false },
})

--[[
require("lazy").setup({


	  "folke/tokyonight.nvim",
	  "nvim-lua/plenary.nvim",
	"nvim-telescope/telescope.nvim",
	  -- or                            , branch = '0.1.x',

	{
      "folke/trouble.nvim",
	config = function()
		require("trouble").setup{
      icons = false,
			}
	end
  },

{
"nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
},
  {'nvim-treesitter/nvim-treesitter-textobjects'},
{'nvim-treesitter/playground'},
    --[[
  use ('ThePrimeagen/harpoon')
  use ('mbbill/undotree')
  use ('tpope/vim-fugitive')
  use ('github/copilot.vim')
  use ('sbdchd/neoformat')
  use('jose-elias-alvarez/null-ls.nvim')
  use('MunifTanjim/prettier.nvim')
    use ('vim-airline/vim-airline')
    use('mhartington/oceanic-next')
    use('tmux-plugins/vim-tmux')
    use('nordtheme/vim')
    use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v1.x',
	  requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-buffer'},
		  {'hrsh7th/cmp-path'},
		  {'saadparwaiz1/cmp_luasnip'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'hrsh7th/cmp-nvim-lua'},

		  -- Snippets
		  {'L3MON4D3/LuaSnip'},
		  {'rafamadriz/friendly-snippets'},
	  },



},{})

--]]
