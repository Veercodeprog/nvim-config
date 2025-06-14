return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
	},

	config = function()
		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")
		local mason_tool_installer = require("mason-tool-installer")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)

		require("fidget").setup({})
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"rust_analyzer",
				"tsserver",
				"html",
				"tailwindcss",
				"pylsp",
				"clangd",
				"pyright",
			},
			handlers = {
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,

				["lua_ls"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								diagnostics = {
									globals = { "vim", "it", "describe", "before_each", "after_each" },
								},
							},
						},
					})
				end,
				["rust_analyzer"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.rust_analyzer.setup({
						-- Server-specific settings. See `:help lspconfig-setup`
						settings = {
							["rust-analyzer"] = {
								cargo = {
									allFeatures = true,
								},
								imports = {
									group = {
										enable = false,
									},
								},
								completion = {
									postfix = {
										enable = false,
									},
								},
								checkOnSave = {
									command = "clippy", -- Use clippy for on-save checks
								},
							},
						},
						on_attach = function(client, bufnr)
							-- Enable autoformat on save using rustfmt
							if client.server_capabilities.documentFormattingProvider then
								vim.api.nvim_create_autocmd("BufWritePre", {
									buffer = bufnr,
									callback = function()
										vim.lsp.buf.format({ async = false })
									end,
								})
							end
						end,
					})
				end,

				["tailwindcss"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.tailwindcss.setup({
						capabilities = capabilities,
						settings = {
							tailwindCSS = {
								emmet = {
									enabled = true,
								},
							},
						},
					})
				end,
			},
		})

		-- Add the mason_tool_installer.setup here
		mason_tool_installer.setup({
			ensure_installed = {
				"stylua",
				"prettier",
				"eslint",
				"eslint_d",
				"rustywind", -- Add rustywind here
			},
		})

		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<C-.>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- For luasnip users.
			}, {
				{ name = "buffer" },
			}),
		})

		vim.diagnostic.config({
			-- update_in_insert = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})
	end,
}
