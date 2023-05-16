-- If you want insert `(` after select function or method item
local cmp_ok, cmp = pcall(require, 'cmp')
local cmp_autopairs_ok, cmp_autopairs = pcall(require, 'nvim-autopairs.completion.cmp')

if cmp_ok and cmp_autopairs_ok then
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
end
