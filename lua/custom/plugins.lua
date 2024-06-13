local plugins = {
    {
      "williamboman/mason.nvim",
      opts = {
        ensure_installed = {
          "gopls",
          "deno",
          "typescript-language-server",
          "bash-language-server",
          "rust-analyzer",
        },
      },
    },
    {
      "mfussenegger/nvim-dap",
      init = function()
        require("core.utils").load_mappings("dap")
      end
    },
    {
      "dreamsofcode-io/nvim-dap-go",
      ft = "go",
      dependencies = "mfussenegger/nvim-dap",
      config = function(_, opts)
        require("dap-go").setup(opts)
        require("core.utils").load_mappings("dap_go")
      end
    },
    {
      "neovim/nvim-lspconfig",
      config = function()
        require "plugins.configs.lspconfig"
        require "custom.configs.lspconfig"
      end,
    },
    {
      "jose-elias-alvarez/null-ls.nvim",
      ft = "go",
      opts = function()
        return require "custom.configs.null-ls"
      end,
    },
    {
      "olexsmir/gopher.nvim",
      ft = "go",
      config = function(_, opts)
        require("gopher").setup(opts)
        require("core.utils").load_mappings("gopher")
      end,
      build = function()
        vim.cmd [[silent! GoInstallDeps]]
      end,
    },
    {
      "ray-x/go.nvim",
      dependencies = {  -- optional packages
        "ray-x/guihua.lua",
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
      },
      config = function()
        require("go").setup()
      end,
      event = {"CmdlineEnter"},
      ft = {"go", 'gomod'},
      build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
    },
  }
  return plugins