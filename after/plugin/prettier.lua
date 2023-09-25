local status , prettier pcall(require, "prettier")
if (not status) then return end

prettier.setup {
    bin = "prettierd",
    filetypes = {

        -- JavaScript
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",

        -- CSS
        "css",
        "less",
        "scss",

        -- HTML
        "html",

        -- JSON
        "json",
        "jsonc",

        -- Markdown
        "markdown",

        -- YAML
        "yaml",

        -- Vue
        "vue",

        -- Lua
        "lua",
    }

}
