return {
  -- Java LSP
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    opts = function(_, opts)
      -- JPA Buddy++ injection
      local original_on_attach = opts.on_attach
      opts.on_attach = function(client, bufnr)
        if original_on_attach then original_on_attach(client, bufnr) end

        -- Check for JPA entity
        local ok_parser, parser = pcall(require, "config.features.jpa.parser")
        if ok_parser and parser.is_jpa_entity(bufnr) then
          vim.notify("JPA Entity detected", vim.log.levels.INFO)
        end

        -- Java compile/run keymap
        vim.keymap.set("n", "<leader>jr", function()
          local cmd = string.format(
            "cd %s && javac %s && java %s",
            vim.fn.expand("%:p:h"), vim.fn.expand("%:t"), vim.fn.expand("%:t:r")
          )
          vim.cmd("!" .. cmd)
        end, { buffer = bufnr, desc = "Java: Compile and Run" })
      end
      return opts
    end,
    config = function(_, opts)
      local install_path = require("mason-registry").get_package("jdtls"):get_install_path()
      local config = vim.tbl_deep_extend("force", opts, {
        cmd = { install_path .. "/bin/jdtls" },
        root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = function()
          require("jdtls").start_or_attach(config)
        end,
      })
    end,
  },

  -- Spring Boot
  {
    "JavaHello/spring-boot.nvim",
    ft = "java",
    dependencies = {
      "mfussenegger/nvim-jdtls",
      { "ibhagwan/fzf-lua", optional = true },
      { "nvim-telescope/telescope.nvim", optional = true },
    },
  },
}
