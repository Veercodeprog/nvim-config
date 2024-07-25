local M = {
	"mfussenegger/nvim-dap",
	event = "VeryLazy",
	dependencies = {
		{
			"nvim-neotest/nvim-nio",

			"rcarriga/nvim-dap-ui",
			"mfussenegger/nvim-dap-python",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-telescope/telescope-dap.nvim",
			"leoluz/nvim-dap-go",
			"mxsdev/nvim-dap-vscode-js",

			"williamboman/mason.nvim",
			"williamboman/mason-nvim-dap.nvim",
		},
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		dapui.setup()
		require("nvim-dap-virtual-text").setup()

		vim.fn.sign_define(
			"DapBreakpoint",
			{ text = "", texthl = "LspDiagnosticsSignError", linehl = "", numhl = "" }
		)

		-- Key Mappings
		local keymap = {
			["<leader>dt"] = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
			["<leader>db"] = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
			["<leader>dc"] = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
			["<leader>dC"] = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
			["<leader>dd"] = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
			["<leader>dg"] = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
			["<leader>di"] = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
			["<leader>do"] = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
			["<leader>du"] = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
			["<leader>dp"] = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
			["<leader>dr"] = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
			["<leader>ds"] = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
			["<leader>dq"] = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
			["<leader>dU"] = { "<cmd>lua require'dapui'.toggle({reset = true})<cr>", "Toggle UI" },
		}

		for k, v in pairs(keymap) do
			vim.api.nvim_set_keymap("n", k, v[1], { noremap = true, silent = true, desc = v[2] })
		end

		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		-- Go Configuration
		require("dap-go").setup()

		-- C++ Configuration
		dap.adapters.cppdbg = {
			id = "cppdbg",
			type = "executable",
			command = "path/to/cpptools/extension/debugAdapters/bin/OpenDebugAD7", -- Adjust this path
		}
		dap.configurations.cpp = {
			{
				name = "Launch file",
				type = "cppdbg",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopAtEntry = true,
			},
			{
				name = "Attach to gdbserver :1234",
				type = "cppdbg",
				request = "launch",
				MIMode = "gdb",
				miDebuggerServerAddress = "localhost:1234",
				miDebuggerPath = "/usr/bin/gdb", -- Adjust as needed
				cwd = "${workspaceFolder}",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
			},
		}

		-- Python Configuration
		require("dap-python").setup("~/.virtualenvs/debugpy/bin/python") -- Adjust the path to debugpy as needed

		-- JavaScript/TypeScript/Node.js Configuration
		require("dap-vscode-js").setup({
			node_path = "node", -- Path of node executable
			adapters = { "pwa-node" }, -- Debug adapters to use
		})
		dap.configurations.javascript = {
			{
				type = "pwa-node",
				request = "launch",
				name = "Launch file",
				program = "${file}",
				cwd = "${workspaceFolder}",
			},
			{
				type = "pwa-node",
				request = "attach",
				name = "Attach",
				processId = require("dap.utils").pick_process,
				cwd = "${workspaceFolder}",
			},
		}
		dap.configurations.typescript = dap.configurations.javascript
		dap.configurations.javascriptreact = dap.configurations.javascript
		dap.configurations.typescriptreact = dap.configurations.javascript
	end,
}

return M

-- return {
-- 	{
-- 		"mfussenegger/nvim-dap",
-- 		dependencies = {
-- 			"leoluz/nvim-dap-go",
-- 			"rcarriga/nvim-dap-ui",
-- 			"theHamsta/nvim-dap-virtual-text",
-- 			"nvim-neotest/nvim-nio",
-- 			"williamboman/mason.nvim",
-- 		},
-- 		config = function()
-- 			local dap = require("dap")
-- 			local ui = require("dapui")
-- 			require("dapui").setup({
-- 				icons = {
-- 					expanded = "▾",
-- 					collapsed = "▸",
-- 					current_frame = "▸",
-- 				},
-- 				mappings = {
-- 					-- Use a table to apply multiple mappings
-- 					expand = { "<CR>", "<2-LeftMouse>" },
-- 					open = "o",
-- 					remove = "d",
-- 					edit = "e",
-- 					repl = "r",
-- 					toggle = "t",
-- 				},
-- 				-- Expand lines larger than the window
-- 				-- Requires >= 0.7
-- 				expand_lines = vim.fn.has("nvim-0.7") == 1,
-- 				layouts = {
-- 					{
-- 						elements = {
-- 							-- Provide as ID strings or tables with "id" and "size" keys
-- 							{
-- 								id = "scopes",
-- 								size = 0.25, -- Can be float or integer > 1
-- 							},
-- 							{ id = "breakpoints", size = 0.25 },
-- 							{ id = "stacks", size = 0.25 },
-- 							{ id = "watches", size = 0.25 },
-- 						},
-- 						size = 40,
-- 						position = "left", -- Can be "left", "right", "top", "bottom"
-- 					},
-- 					{
-- 						elements = {
-- 							"repl",
-- 							"console",
-- 						},
-- 						size = 0.25,
-- 						position = "bottom", -- Can be "left", "right", "top", "bottom"
-- 					},
-- 				},
-- 				controls = {
-- 					-- Requires Neovim nightly (or 0.8 when released)
-- 					enabled = true,
-- 					-- Display controls in this element
-- 					element = "repl",
-- 					icons = {
-- 						pause = "",
-- 						play = "",
-- 						step_into = "",
-- 						step_over = "",
-- 						step_out = "",
-- 						step_back = "",
-- 						run_last = "↻",
-- 						terminate = "□",
-- 					},
-- 				},
-- 				floating = {
-- 					max_height = nil, -- These can be integers or a float between 0 and 1.
-- 					max_width = nil, -- Floats will be treated as percentage of your screen.
-- 					border = "single", -- Border style. Can be "single", "double" or "rounded"
-- 					mappings = {
-- 						close = { "q", "<Esc>" },
-- 					},
-- 				},
-- 				windows = { indent = 1 },
-- 				render = {
-- 					max_type_length = nil, -- Can be integer or nil.
-- 				},
-- 			})
--
-- 			require("dapui").setup()
-- 			require("dap-go").setup()
--
-- 			require("nvim-dap-virtual-text").setup({
-- 				-- This just tries to mitigate the chance that I leak tokens here. Probably won't stop it from happening...
-- 				-- display_callback = function(variable)
-- 				-- 	local name = string.lower(variable.name)
-- 				-- 	local value = string.lower(variable.value)
-- 				-- 	if name:match("secret") or name:match("api") or value:match("secret") or value:match("api") then
-- 				-- 		return "*****"
-- 				-- 	end
-- 				--
-- 				-- 	if #variable.value > 15 then
-- 				-- 		return " " .. string.sub(variable.value, 1, 15) .. "... "
-- 				-- 	end
-- 				--
-- 				-- 	return " " .. variable.value
-- 				-- end,
-- 			})
--
-- 			-- Handled by nvim-dap-go
-- 			-- dap.adapters.go = {
-- 			--   type = "server",
-- 			--   port = "${port}",
-- 			--   executable = {
-- 			--     command = "dlv",
-- 			--     args = { "dap", "-l", "127.0.0.1:${port}" },
-- 			--   },
-- 			-- }
--
-- 			local elixir_ls_debugger = vim.fn.exepath("elixir-ls-debugger")
-- 			if elixir_ls_debugger ~= "" then
-- 				dap.adapters.mix_task = {
-- 					type = "executable",
-- 					command = elixir_ls_debugger,
-- 				}
--
-- 				dap.configurations.elixir = {
-- 					{
-- 						type = "mix_task",
-- 						name = "phoenix server",
-- 						task = "phx.server",
-- 						request = "launch",
-- 						projectDir = "${workspaceFolder}",
-- 						exitAfterTaskReturns = false,
-- 						debugAutoInterpretAllModules = false,
-- 					},
-- 				}
-- 			end
--
-- 			vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
-- 			vim.keymap.set("n", "<leader>gb", dap.run_to_cursor)
--
-- 			-- Eval var under cursor
-- 			vim.keymap.set("n", "<leader>?", function()
-- 				require("dapui").eval(nil, { enter = true })
-- 			end)
--
-- 			vim.keymap.set("n", "<leader>dc", dap.continue)
-- 			vim.keymap.set("n", "<F2>", dap.step_into)
-- 			vim.keymap.set("n", "<F3>", dap.step_over)
-- 			vim.keymap.set("n", "<F4>", dap.step_out)
-- 			vim.keymap.set("n", "<F5>", dap.step_back)
-- 			vim.keymap.set("n", "<F13>", dap.restart)
--
-- 			vim.keymap.set("n", "<leader>dm", function()
-- 				require("dapui").toggle()
-- 			end)
--
-- 			dap.listeners.before.attach.dapui_config = function()
-- 				ui.open()
-- 			end
-- 			dap.listeners.before.launch.dapui_config = function()
-- 				ui.open()
-- 			end
-- 			dap.listeners.before.event_terminated.dapui_config = function()
-- 				ui.close()
-- 			end
-- 			dap.listeners.before.event_exited.dapui_config = function()
-- 				ui.close()
-- 			end
-- 		end,
-- 	},
-- }
