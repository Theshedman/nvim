return {
  -- Extend lang.helm extra with chart workflow keymaps
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = function(_, opts)
      LazyVim.lsp.on_attach(function(client, bufnr)
        if client.name ~= "helm_ls" then
          return
        end

        local map = function(keys, fn, desc)
          vim.keymap.set("n", keys, fn, { buffer = bufnr, desc = desc })
        end

        local function find_chart_root()
          local file = vim.api.nvim_buf_get_name(bufnr)
          local chart = vim.fs.find("Chart.yaml", { path = vim.fn.fnamemodify(file, ":h"), upward = true })[1]
          if chart then
            return vim.fn.fnamemodify(chart, ":h")
          end
          return vim.fn.expand("%:p:h")
        end

        map("<leader>jt", function()
          local root = find_chart_root()
          vim.cmd("!cd " .. root .. " && helm template .")
        end, "Helm: template")

        map("<leader>jl", function()
          local root = find_chart_root()
          vim.cmd("!cd " .. root .. " && helm lint .")
        end, "Helm: lint")
      end)
    end,
  },
}
