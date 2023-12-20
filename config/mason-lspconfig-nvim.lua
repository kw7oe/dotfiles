require('mason-lspconfig').setup({
  ensure_installed = { "rust_analyzer", "tailwindcss", "tsserver" },
  automatic_installation = false,
})
