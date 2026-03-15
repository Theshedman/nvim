return {
  -- Extend lang.terraform extra with workflow keymaps
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = function(_, opts)
      LazyVim.lsp.on_attach(function(client, bufnr)
        if client.name ~= "terraformls" then
          return
        end

        local map = function(keys, fn, desc)
          vim.keymap.set("n", keys, fn, { buffer = bufnr, desc = desc })
        end

        local dir = vim.fn.expand("%:p:h")

        map("<leader>ji", function()
          vim.cmd("!cd " .. dir .. " && terraform init")
        end, "Terraform: init")

        map("<leader>jp", function()
          vim.cmd("!cd " .. dir .. " && terraform plan")
        end, "Terraform: plan")

        map("<leader>jv", function()
          vim.cmd("!cd " .. dir .. " && terraform validate")
        end, "Terraform: validate")
      end)
    end,
  },
}
