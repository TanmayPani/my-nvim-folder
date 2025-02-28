return {
  {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_auto_open_output = false
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_wrap_output = true
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true

      -- don't change the mappings (unless it's related to your bug)
      vim.keymap.set("n", "<localleader>mi", ":MoltenInit<CR>")
      vim.keymap.set("n", "<localleader>e", ":MoltenEvaluateOperator<CR>")
      vim.keymap.set("n", "<localleader>rr", ":MoltenReevaluateCell<CR>")
      vim.keymap.set("v", "<localleader>r", ":<C-u>MoltenEvaluateVisual<CR>gv")
      vim.keymap.set("n", "<localleader>os", ":noautocmd MoltenEnterOutput<CR>")
      vim.keymap.set("n", "<localleader>oh", ":MoltenHideOutput<CR>")
      vim.keymap.set("n", "<localleader>md", ":MoltenDelete<CR>")
    end,
  },
}
