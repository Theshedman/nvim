return {
  -- Neotest
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- Adapters
      "rcasia/neotest-java",
      "nvim-neotest/neotest-jest",
      "alfaix/neotest-gtest",
      "nvim-neotest/neotest-go",
      "nvim-neotest/neotest-python",
      "rouge8/neotest-rust",
    },
    keys = {
      { "<leader>tn", function() require("neotest").run.run() end, desc = "Test: Run Nearest" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Test: Run File" },
      { "<leader>ta", function() require("neotest").run.run(vim.fn.getcwd()) end, desc = "Test: Run All" },
      { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Test: Run Last" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Test: Toggle Summary" },
      { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Test: Show Output" },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Test: Toggle Output Panel" },
      { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Test: Debug Nearest" },
      { "<leader>tS", function() require("neotest").run.stop() end, desc = "Test: Stop" },
      { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Test: Watch File" },
      { "]T", function() require("neotest").jump.next({ status = "failed" }) end, desc = "Next Failed Test" },
      { "[T", function() require("neotest").jump.prev({ status = "failed" }) end, desc = "Previous Failed Test" },
    },
    opts = function()
      return {
        adapters = {
          require("neotest-java"),
          require("neotest-jest")({
            jestCommand = "npm test --",
            jestConfigFile = "jest.config.js",
            env = { CI = true },
            cwd = function() return vim.fn.getcwd() end,
          }),
          require("neotest-gtest"),
          require("neotest-go"),
          require("neotest-python"),
          require("neotest-rust"),
        },
        status = { virtual_text = true },
        output = { open_on_run = true },
      }
    end,
    config = function(_, opts)
      require("neotest").setup(opts)
    end,
  },

  -- Coverage
  {
    "andythigpen/nvim-coverage",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "Coverage", "CoverageLoad", "CoverageShow", "CoverageHide", "CoverageToggle", "CoverageSummary" },
    keys = {
      { "<leader>tc", function() require("coverage").load(true); require("coverage").show() end, desc = "Test: Show Coverage" },
      { "<leader>tC", function() require("coverage").clear() end, desc = "Test: Clear Coverage" },
    },
    opts = {
      commands = true,
      highlights = {
        covered = { fg = "#C3E88D" },
        uncovered = { fg = "#F07178" },
      },
      signs = {
        covered = { hl = "CoverageCovered", text = "▎" },
        uncovered = { hl = "CoverageUncovered", text = "▎" },
      },
      summary = { min_coverage = 80.0 },
      lang = {
        python = { coverage_command = "coverage json --fail-under=0 -q -o -" },
      },
    },
  },
}
