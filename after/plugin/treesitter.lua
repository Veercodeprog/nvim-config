 require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "javascript", "typescript","go","rust","python", "c", "lua", "vim", "vimdoc", "query" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")

   indent = {
    enable = true,
  },
  fold = {
    enable = true,  -- Enable code folding
  },
  highlight = {
      enable = true,

    
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  textobjects = {
        select = {
            enable = true,
            lookahead = true,  -- Enable text objects to include empty lines
            keymaps = {
                  ["<leader>af"] = "@function.outer",
        ["<leader>i"] = "@function.inner",
        ["<leader>ad"] = "@tag.outer",
        ["<leader>d"] = "@tag.inner",
            },
        },
    },
}
