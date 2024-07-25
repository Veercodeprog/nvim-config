return {
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*", -- Replace with the latest version
		build = "make install_jsregexp",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			local ls = require("luasnip")
			require("luasnip.loaders.from_vscode").lazy_load() -- Load friendly-snippets

			-- Extend filetypes
			ls.filetype_extend("javascript", { "javascriptreact" }) -- React
			ls.filetype_extend("python", { "python" }) -- Python
			ls.filetype_extend("cpp", { "cpp" }) -- C++

			-- Key mappings for expanding and navigating snippets
			vim.keymap.set({ "i" }, "<C-s>e", function()
				ls.expand()
			end, { silent = true })
			vim.keymap.set({ "i", "s" }, "<C-s>;", function()
				ls.jump(1)
			end, { silent = true })
			vim.keymap.set({ "i", "s" }, "<C-s>,", function()
				ls.jump(-1)
			end, { silent = true })
			vim.keymap.set({ "i", "s" }, "<C-E>", function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end, { silent = true })
		end,
	},
}
