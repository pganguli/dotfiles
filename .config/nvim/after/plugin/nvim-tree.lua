local tree_ok, tree = pcall(require, 'nvim-tree')
local tree_api_ok, tree_api = pcall(require, 'nvim-tree.api')

if tree_ok and tree_api_ok then
    tree.setup({
        renderer = { icons = {
            show = {
                file = false
            },
            glyphs = {
                default = "",
                symlink = "",
                bookmark = "",
                modified = "",
                folder = {
                    arrow_closed = "⏵",
                    arrow_open = "⏷",
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                    symlink_open = "",

                },
                git = {
                    unstaged = "✗",
                    staged = "✓",
                    unmerged = "●",
                    renamed = "➜",
                    untracked = "★",
                    deleted = "-",
                    ignored = "◌",

                }
            }}},
        on_attach = function(bufnr)
            tree_api.config.mappings.default_on_attach(bufnr) -- default mappings
        end
    })
end
