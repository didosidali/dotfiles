local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',
    'tpope/vim-sleuth',
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'williamboman/mason.nvim', config = true },
            'williamboman/mason-lspconfig.nvim',
            { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
            'folke/neodev.nvim',
        },
    },

    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'rafamadriz/friendly-snippets',
        },
    },
    { 'folke/which-key.nvim', opts = {} },
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
            on_attach = function(bufnr)
                vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })

                -- don't override the built-in and fugitive keymaps
                local gs = package.loaded.gitsigns
                vim.keymap.set({'n', 'v'}, ']c', function()
                    if vim.wo.diff then return ']c' end
                    vim.schedule(function() gs.next_hunk() end)
                    return '<Ignore>'
                end, {expr=true, buffer = bufnr, desc = "Jump to next hunk"})
                vim.keymap.set({'n', 'v'}, '[c', function()
                    if vim.wo.diff then return '[c' end
                    vim.schedule(function() gs.prev_hunk() end)
                    return '<Ignore>'
                end, {expr=true, buffer = bufnr, desc = "Jump to previous hunk"})
            end,
        },
    },
    -- {
    --     'navarasu/onedark.nvim',
    --     priority = 1000,
    --     config = function()
    --         vim.cmd.colorscheme 'onedark'
    --     end,
    -- },
    {
        'rose-pine/neovim',
	as = 'rose-pine',
	config = function()
	        vim.cmd('colorscheme rose-pine')
	end
    },
    {
        'nvim-lualine/lualine.nvim',
        opts = {
            options = {
                icons_enabled = false,
                theme = 'onedark',
                component_separators = '|',
                section_separators = '',
            },
        },
    },

    {
        'lukas-reineke/indent-blankline.nvim',
        main='ibl',
        opts = {
        },
    },
    { 'numToStr/Comment.nvim', opts = {} },
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
        },
    },
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
    },
    {
      "christoomey/vim-tmux-navigator",
      lazy = false,
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        version = "*",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
    },
    { 
        "lervag/vimtex",
        lazy = false,
        init = function()
            vim.g.vimtex_view_method = 'zathura'
            vim.g.latex_view_general_viewer = 'zathura'
            vim.g.vimtex_view_general_viewer = 'zathura'
            -- vim.g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]
            vim.g.vimtex_view_general_options = [[-x "nvr --remote +%{line} %{input}" ${@:2}]]
            vim.g.vimtex_quickfix_enabled = 1
            vim.g.vimtex_syntax_enabled = 1
            vim.g.vimtex_quickfix_mode = 0
            vim.g.vimtex_compiler_progname = 'nvr'
        end,
    },
    {
        'pocco81/true-zen.nvim',
    },
    -- {
    --     'rhysd/vim-grammarous',
    --     config = function()
    --         vim.keymap.set("n", "<leader>x", "<Plug>(grammarous-close-info-window)")
    --         vim.keymap.set("n", "<c-n>", "<Plug>(grammarous-move-to-next-error)")
    --         vim.keymap.set("n", "<c-p>", "<Plug>(grammarous-move-to-previous-error)")
    --     end,
    -- },
    {
	'nvim-treesitter/playground'
    },
    {
	'mbbill/undotree'
    },
    {
        "David-Kunz/gen.nvim",
    },
    {
        'Vimjas/vim-python-pep8-indent'
    },
    {
        'norcalli/nvim-colorizer.lua'
    },
})
