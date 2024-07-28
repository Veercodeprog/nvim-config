return {
	require("nvim-web-devicons").setup({
		-- your icons configuration comes here
		-- for example, you can change the folder icons like this:
		override = {
			folder = {
				arrow_closed = "",
				arrow_open = "",
				default = "",
				open = "",
				empty = "",
				empty_open = "",
				symlink = "",
				symlink_open = "",
			},
			-- and so on
		},
	}),
}
