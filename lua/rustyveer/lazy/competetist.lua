return {
	"xeluxee/competitest.nvim",
	dependencies = { "MunifTanjim/nui.nvim" },
	config = function()
		require("competitest").setup({
			popup = {
				enable_nui = true,
				nui = {
					border = {
						style = "rounded",
						highlight = "FloatBorder",
					},
					win_options = {
						winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
					},
				},
			},
			mappings = {
				next_test = "<C-,>",
				prev_test = "<C-.>",
				run_tests = "<C-/>",
				open_result = "<C-+>",
			},
		})
	end,
}
