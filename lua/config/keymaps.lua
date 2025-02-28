-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--vim.keymap.set("n", "<localleader>ip", function()
--  local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
--  if venv ~= nil then
--    -- in the form of /home/benlubas/.virtualenvs/VENV_NAME
--    venv = string.match(venv, "/.+/(.+)")
--    vim.cmd(("MoltenInit %s"):format(venv))
--  else
--    vim.cmd("MoltenInit python3")
--  end
--end, { desc = "Initialize Molten for python3", silent = true })
local function markdown_codeblock(language, content)
  return "\\`\\`\\`{" .. language .. "}\n" .. content .. "\n\\`\\`\\`"
end

local python_term = require("toggleterm.terminal").Terminal:new({ cmd = "python3", hidden = true, direction = "float" })
vim.keymap.set("n", "<C-p>", function()
  python_term:toggle()
end, { noremap = true, silent = true })

local quarto_notebook_cmd = 'nvim -c enew -c "set filetype=quarto"'
  .. ' -c "norm GO## IPython\nThis is Quarto IPython notebook. Syntax is the same as in markdown\n\n'
  .. markdown_codeblock("python", "# enter code here\n")
  .. '"'
  .. ' -c "norm Gkk"'
  -- This line needed because QuartoActivate and MoltenInit commands must be accessible; should be adjusted depending on plugin manager
  .. " -c \"lua require('lazy.core.loader').load({'molten-nvim', 'quarto-nvim'}, {cmd = 'Lazy load'})\""
  .. ' -c "MoltenInit python3" -c QuartoActivate -c startinsert'

local molten_term =
  require("toggleterm.terminal").Terminal:new({ cmd = quarto_notebook_cmd, hidden = true, direction = "float" })
vim.keymap.set("n", "<C-p>", function()
  molten_term:toggle()
end, { noremap = true, silent = true })
vim.keymap.set("t", "<C-p>", function()
  vim.cmd("stopinsert")
  molten_term:toggle()
end, { noremap = true, silent = true })

local runner = require("quarto.runner")
vim.keymap.set("n", "<localleader>rc", runner.run_cell, { desc = "run cell", silent = true })
vim.keymap.set("n", "<localleader>ra", runner.run_above, { desc = "run cell and above", silent = true })
vim.keymap.set("n", "<localleader>rA", runner.run_all, { desc = "run all cells", silent = true })
vim.keymap.set("n", "<localleader>rl", runner.run_line, { desc = "run line", silent = true })
vim.keymap.set("v", "<localleader>r", runner.run_range, { desc = "run visual range", silent = true })
vim.keymap.set("n", "<localleader>RA", function()
  runner.run_all(true)
end, { desc = "run all cells of all languages", silent = true })

--Utilities for image.nvim plugin
local image = require("image")

local function clear_all_images()
  local bufnr = vim.api.nvim_get_current_buf()
  local images = image.get_images({ buffer = bufnr })
  for _, img in ipairs(images) do
    img:clear()
  end
end

local function get_image_at_cursor(buf)
  local images = image.get_images({ buffer = buf })
  local row = vim.api.nvim_win_get_cursor(0)[1] - 1
  for _, img in ipairs(images) do
    if img.geometry ~= nil and img.geometry.y == row then
      local og_max_height = img.global_state.options.max_height_window_percentage
      img.global_state.options.max_height_window_percentage = nil
      return img, og_max_height
    end
  end
  return nil
end

local create_preview_window = function(img, og_max_height)
  local buf = vim.api.nvim_create_buf(false, true)
  local win_width = vim.api.nvim_get_option_value("columns", {})
  local win_height = vim.api.nvim_get_option_value("lines", {})
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    style = "minimal",
    width = win_width,
    height = win_height,
    row = 0,
    col = 0,
    zindex = 1000,
  })
  vim.keymap.set("n", "q", function()
    vim.api.nvim_win_close(win, true)
    img.global_state.options.max_height_window_percentage = og_max_height
  end, { buffer = buf })
  return { buf = buf, win = win }
end

local handle_zoom = function(bufnr)
  local img, og_max_height = get_image_at_cursor(bufnr)
  if img == nil then
    return
  end

  local preview = create_preview_window(img, og_max_height)
  image.hijack_buffer(img.path, preview.win, preview.buf)
end

vim.keymap.set("n", "<leader>io", function()
  local bufnr = vim.api.nvim_get_current_buf()
  handle_zoom(bufnr)
end, { buffer = true, desc = "image [o]pen" })

vim.keymap.set("n", "<leader>ic", clear_all_images, { desc = "image [c]lear" })
