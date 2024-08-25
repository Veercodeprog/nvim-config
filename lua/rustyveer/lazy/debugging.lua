local M = {
	"mfussenegger/nvim-dap",
	event = "VeryLazy",
	dependencies = {
		"nvim-neotest/nvim-nio",

		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"nvim-telescope/telescope-dap.nvim",
		"leoluz/nvim-dap-go",
		"mfussenegger/nvim-dap-python",
		"mxsdev/nvim-dap-vscode-js",
		"williamboman/mason.nvim",
		"williamboman/mason-nvim-dap.nvim",
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

		dap.adapters.cppdbg = {
			id = "cppdbg",
			type = "executable",
			command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7",
			options = {
				detached = false,
			},
		}

		-- Debugger configurations
		dap.configurations.cpp = {
			{
				name = "Launch file",
				type = "cppdbg",
				request = "launch",
				program = function()
					return vim.fn.input("", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopAtEntry = true,
			},
			{
				name = "Debug Program",
				type = "cppdbg",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopAtEntry = true,
				MIMode = "lldb",
				setupCommands = {
					{
						description = "Enable pretty-printing for lldb",
						text = "-enable-pretty-printing",
						ignoreFailures = true,
					},
				},
			},
		}

		-- Apply configurations for C and Rust
		dap.configurations.c = dap.configurations.cpp
		dap.configurations.rust = dap.configurations.cpp
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
