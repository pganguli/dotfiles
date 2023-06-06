-- This file can be loaded by calling `lua require('plugins')` from your init.vim

local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        -- Only required if you have packer configured as `opt`
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    -- packer can manage itself
    use('wbthomason/packer.nvim')

    -- moonfly - Dark theme
    use({ 'bluz71/vim-moonfly-colors', as = 'moonfly',
        config = function ()
            vim.cmd.colorscheme('moonfly')                -- Set colorscheme to moonfly
            vim.cmd('highlight! link Whitespace NonText') -- Force colors of NonText for Whitespace as well
        end
    })

    -- telescope - Fuzzy finder
    use({ 'nvim-telescope/telescope.nvim', tag = '0.1.1',
        requires = { 'nvim-lua/plenary.nvim' }
    })

    -- nvim-treesitter - Treesitter-based highlighting
    use({ 'nvim-treesitter/nvim-treesitter',
        run = function ()
            require("nvim-treesitter.install").update({ with_sync = false })
        end
    })

    -- undotree - Visualize undo history
    use('mbbill/undotree')

    -- vim-fugitive - Git integration
    use('tpope/vim-fugitive')

    -- vim-surround - Surrounding brackets and quotes
    use('tpope/vim-surround')

    -- vim-commentary - Comment / Uncomment code blocks
    use('tpope/vim-commentary')

    -- nvim-tree - File Explorer
    use('nvim-tree/nvim-tree.lua')

    -- nvim-autopairs - Autopair brackets and quotes
    use({ 'windwp/nvim-autopairs',
        config = function() require('nvim-autopairs').setup({
            disable_in_macro = true,                  -- disable when recording or executing a macro
            break_undo = false,                       -- switch for basic rule break undo sequence
        }) end
    })

    -- LSP
    use({ 'VonHeikemen/lsp-zero.nvim', branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },           -- Required
            { 'williamboman/mason.nvim',           -- Optional
              run = function() pcall(vim.cmd, 'MasonUpdate') end,
            },
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},                  -- Required
            {'hrsh7th/cmp-nvim-lsp'},              -- Required
            {'L3MON4D3/LuaSnip'},                  -- Required
            {'hrsh7th/cmp-path'},                  -- Optional
            {'hrsh7th/cmp-buffer'},                -- Optional
        }
    })

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
