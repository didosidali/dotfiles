require('rose-pine').setup({
    -- disable_background = true,
    variant = "main",
    styles = {
        -- transparency = true,
    }
})

-- require('onedark').setup({
--     disable_background = true,
--     style = "custom"
-- })

function Coloring(color)
    color = color or "rose-pine"
    -- color = color or "onedark"
    vim.cmd.colorscheme(color)
    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
end

Coloring()
