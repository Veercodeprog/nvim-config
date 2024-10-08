require("rustyveer.set")

require("rustyveer.remap")
require("rustyveer.lazy_init")
-- Set PATH for Neovim
vim.env.PATH = vim.env.PATH .. ":/opt/homebrew/bin:/usr/local/bin"
-- vim.cmd('!alias g++="g++ -std=c++20"')
vim.cmd("let $SHELL = '/bin/zsh'") -- or /bin/bash depending on your shell
vim.cmd("let $GPP = 'g++ -std=c++20'")
vim.env.SHELL = "/bin/zsh" -- or /bin/bash if that's your shell

-- Make sure Neovim sources your shell profile
-- vim.cmd([[source ~/.zshrc]]) -- or ~/.bashrc if you use bash

-- DO.not
-- DO NOT INCLUDE THIS

-- If i want to keep doing lsp debugging
-- function restart_htmx_lsp()
--     require("lsp-debug-tools").restart({ expected = {}, name = "htmx-lsp", cmd = { "htmx-lsp", "--level", "DEBUG" }, root_dir = vim.loop.cwd(), });
-- end

-- DO NOT INCLUDE THIS
-- DO.not
-- For a block cursor

-- For a vertical bar cursor
-- vim.opt.guicursor = "n-v-c:ver25,i-ci-ve:ver25,r-cr-o:hor20"

-- For an underline cursor
-- vim.opt.guicursor = "n-v-c:hor20,i-ci-ve:ver25,r-cr-o:hor20"

local augroup = vim.api.nvim_create_augroup
local ThePrimeagenGroup = augroup("ThePrimeagen", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

function R(name)
	require("plenary.reload").reload_module(name)
end

vim.filetype.add({
	extension = {
		templ = "templ",
	},
})

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

autocmd({ "BufWritePre" }, {
	group = ThePrimeagenGroup,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

autocmd("LspAttach", {
	group = ThePrimeagenGroup,
	callback = function(e)
		local opts = { buffer = e.buf }
		vim.keymap.set("n", "gd", function()
			vim.lsp.buf.definition()
		end, opts)
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, opts)
		vim.keymap.set("n", "<leader>vws", function()
			vim.lsp.buf.workspace_symbol()
		end, opts)
		vim.keymap.set("n", "<leader>vd", function()
			vim.diagnostic.open_float()
		end, opts)
		vim.keymap.set("n", "<leader>vca", function()
			vim.lsp.buf.code_action()
		end, opts)
		vim.keymap.set("n", "<leader>vrr", function()
			vim.lsp.buf.references()
		end, opts)
		vim.keymap.set("n", "<leader>vrn", function()
			vim.lsp.buf.rename()
		end, opts)
		vim.keymap.set("i", "<C-h>", function()
			vim.lsp.buf.signature_help()
		end, opts)
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.goto_next()
		end, opts)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.goto_prev()
		end, opts)
	end,
})
vim.opt.wrap = true

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
-- vim.cmd("colorscheme catppuccin")

vim.api.nvim_set_keymap("n", "<C-,>", "<cmd>CompetitestNextTest<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-.>", "<cmd>CompetitestPrevTest<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-/>", "<cmd>CompetitestRunTests<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-+>", "<cmd>CompetitestOpenResult<CR>", { noremap = true, silent = true })

vim.o.guifont = "FiraCode Nerd Font:h17"
