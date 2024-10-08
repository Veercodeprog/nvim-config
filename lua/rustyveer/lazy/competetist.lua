return {
	"xeluxee/competitest.nvim",
	dependencies = { "MunifTanjim/nui.nvim" },
	config = function()
		require("competitest").setup({
			compile_command = {
				c = { exec = "gcc", args = { "-Wall", "$(FNAME)", "-o", "$(FNOEXT)" } },
				cpp = { exec = "/opt/homebrew/bin/g++", args = { "-Wall", "$(FNAME)", "-o", "$(FNOEXT)" } }, -- Ensure this path is correct
				rust = { exec = "rustc", args = { "$(FNAME)" } },
				java = { exec = "javac", args = { "$(FNAME)" } },
			},
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
