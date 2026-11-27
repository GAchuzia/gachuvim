return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "mfussenegger/nvim-dap-python",
    },
    -- Leader keys, since macOS grabs some of the F keys.
    keys = {
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle breakpoint",
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Start / continue",
      },
      {
        "<leader>dn",
        function()
          require("dap").step_over()
        end,
        desc = "Step over",
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "Step into",
      },
      {
        "<leader>do",
        function()
          require("dap").step_out()
        end,
        desc = "Step out",
      },
      {
        "<leader>dt",
        function()
          require("dap").terminate()
        end,
        desc = "Stop debugging",
      },
      {
        "<leader>dm",
        function()
          require("dap-python").test_method()
        end,
        desc = "Debug test under cursor",
      },
      {
        "<leader>du",
        function()
          require("dapui").toggle()
        end,
        desc = "Debug UI",
      },
    },
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized.dapui = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui = function()
        dapui.close()
      end
      require("dap-python").setup(
        vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
      )
    end,
  },
}
