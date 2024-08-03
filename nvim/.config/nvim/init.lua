require("general")

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- require("indent-blankline").setup {
--     indent = { char = '┊' },
-- }
-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`



-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
-- [[ Configure neo-tree ]]]
-- see help NeoTree
-- require("neo-tree").setup()
-- require("nvim-web-devicons").setup()

-- [[ Configure Null Ls ]]

-- vimtex.setup()
-- vim.g.vimtex_view_method = "okular"
-- vim.g.vimtex_view_genral_viewer = "okular"
-- vim.g.vimtex_view_genral_options = "--unique file:@pdf/#src:@line@tex"
-- vim.g.vimtex_compiler_method = 'latexrun'
