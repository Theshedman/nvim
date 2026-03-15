return {
  -- Extend lang.yaml extra with schema-switching keymap
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = function(_, opts)
      LazyVim.lsp.on_attach(function(client, bufnr)
        if client.name ~= "yamlls" then
          return
        end

        vim.keymap.set("n", "<leader>jy", function()
          vim.ui.input({ prompt = "YAML schema URL:" }, function(schema)
            if not schema or schema == "" then
              return
            end
            local params = {
              settings = {
                yaml = {
                  schemas = { [schema] = vim.api.nvim_buf_get_name(bufnr) },
                },
              },
            }
            client.notify("workspace/didChangeConfiguration", params)
            vim.notify("Set YAML schema: " .. schema, vim.log.levels.INFO)
          end)
        end, { buffer = bufnr, desc = "YAML: Set schema for buffer" })
      end)
    end,
  },
}
