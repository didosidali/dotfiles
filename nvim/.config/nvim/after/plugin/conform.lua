local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    -- Conform will run multiple formatters sequentially
    python = { "isort", "black" },
    toml = { "tombi" },
    -- You can customize some of the format options for the filetype (:help conform.format)
    rust = { "rustfmt", lsp_format = "fallback" },
    -- Conform will run the first available formatter
    javascript = { "prettierd", "prettier", stop_after_first = true },
  },
  format_on_save = {
    lsp_format = "fallback",
    async = false,
    timeout_ms = 500,
  }
})

vim.keymap.set({ "n", "v" }, "<leader>mp", function()
  conform.format({
    lsp_format = "fallback",
    async = false,
    timeout_ms = 500
  })
end, { desc = "Format file or visual" })

conform.formatters.black = {
  prepend_args = { "--line-length", "79" },
  -- The base args are { "-filename", "$FILENAME" } so the final args will be
  -- { "-i", "2", "-filename", "$FILENAME" }
}
