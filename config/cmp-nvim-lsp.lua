local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
local lsp_attach = function(client, bufnr)
  local opts = { buffer = true, noremap = true }

   vim.keymap.set('n', '<c-]>', '<cmd> lua vim.lsp.buf.definition()<CR>', opts)
   vim.keymap.set('n', 'K', '<cmd> lua vim.lsp.buf.hover()<CR>', opts)
   vim.keymap.set('n', 'gD', '<cmd> lua vim.lsp.buf.implementation()<CR>', opts)
   vim.keymap.set('n', '<c-k>', '<cmd> lua vim.lsp.buf.signature_help()<CR>', opts)
   vim.keymap.set('n', 'gD', '<cmd> lua vim.lsp.buf.type_definition()<CR>', opts)
   vim.keymap.set('n', 'gr', '<cmd> lua vim.lsp.buf.references()<CR>', opts)
   vim.keymap.set('n', 'g0', '<cmd> lua vim.lsp.buf.document_symbol()<CR>', opts)
   vim.keymap.set('n', 'gW', '<cmd> lua vim.lsp.buf.workspace_symbol()<CR>', opts)
   vim.keymap.set('n', 'gd', '<cmd> lua vim.lsp.buf.definition()<CR>', opts)
   vim.keymap.set('n', 'ga', '<cmd> lua vim.lsp.buf.code_action()<CR>', opts)
end

require("elixir").setup({
  elixirls = { enable = true },
  -- nextls = {
  --   enable = true,
  --   cmd = "/Users/kai/.local/share/nvim/mason/bin/nextls",
  --   init_options = {
  --     experimental = {
  --       completions = {
  -- 	  enable = true
  --       }
  --     }
  --   },
  --   on_attach = lsp_attach
  -- }

  -- elixirls = {
  --   on_attach = lsp_attach,
  --   tag = "v0.15.1"
  -- },
})

-- vim.lsp.set_log_level('debug')
local lspconfig = require('lspconfig')
local rt = {
    server = {
        cmd_env = { CARGO_TARGET_DIR = "target/analyzer" },
        settings = {
            ['rust-analyzer'] = {
                checkOnSave = {
                    extraArgs = { "--target-dir", "target/analyzer" }
                },
            },
        },
    },
}
require("rust-tools").setup(rt)

-- local rt = require("rust-tools")
--
-- rt.setup({
--   server = {
--     on_attach = lsp_attach,
--     capabilities = lsp_capabilities,
--     flags = {
--       exit_timeout = 0,
--     }
--   },
-- })

-- require('mason-lspconfig').setup_handlers({
--   function(server_name)
--     lspconfig[server_name].setup({
--       on_attach = lsp_attach,
--       capabilities = lsp_capabilities,
--     })
--   end,
-- })

-- lspconfig.rust_analyzer.setup({
--   on_attach = lsp_attach,
--   capabilities = lsp_capabilities,
-- })

lspconfig.tailwindcss.setup({
  on_attach = lsp_attach,
  capabilities = lsp_capabilities,
  filetypes = { 'html', 'eelixir', 'heex', 'eex' },
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          'class[:]\\s*"([^"]*)"',
          'class[=]\\s*"([^"]*)"',
        },
      },
    },
  },
})
