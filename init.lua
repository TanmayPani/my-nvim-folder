-- local rocks_config = {
--     rocks_path = vim.env.HOME .. "/.local/share/nvim/rocks",
-- }
--
-- vim.g.rocks_nvim = rocks_config
--
-- local luarocks_path = {
--     vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?.lua"),
--     vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?", "init.lua"),
-- }
-- package.path = package.path .. ";" .. table.concat(luarocks_path, ";")
--
-- local luarocks_cpath = {
--     vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.so"),
--     vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.so"),
--     -- Remove the dylib and dll paths if you do not need macos or windows support
--     vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.dylib"),
--     vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.dylib"),
--     vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.dll"),
--     vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.dll"),
-- }
-- package.cpath = package.cpath .. ";" .. table.concat(luarocks_cpath, ";")
--
-- vim.opt.runtimepath:append(vim.fs.joinpath(rocks_config.rocks_path, "lib", "luarocks", "rocks-5.1", "rocks.nvim", "*"))

-- Provide a command to create a blank new Python notebook
-- note: the metadata is needed for Jupytext to understand how to parse the notebook.
-- if you use another language than Python, you should change it in the template.
-- bootstrap lazy.nvim, LazyVim and your plugins
--require("config.global")
--require("config.autocommands")
--require("config.redir")
require("config.lazy")

require("quarto").setup({
  codeRunner = {
    ft_runners = {
      { python = "molten" },
    },
  },
})

require("toggleterm").setup({})

local default_notebook = [[
  {
    "cells": [
     {
      "cell_type": "markdown",
      "metadata": {},
      "source": [
        ""
      ]
     }
    ],
    "metadata": {
     "kernelspec": {
      "display_name": "Python 3",
      "language": "python",
      "name": "python3"
     },
     "language_info": {
      "codemirror_mode": {
        "name": "ipython"
      },
      "file_extension": ".py",
      "mimetype": "text/x-python",
      "name": "python",
      "nbconvert_exporter": "python",
      "pygments_lexer": "ipython3"
     }
    },
    "nbformat": 4,
    "nbformat_minor": 5
  }
]]

local function new_notebook(filename)
  local path = filename .. ".ipynb"
  local file = io.open(path, "w")
  if file then
    file:write(default_notebook)
    file:close()
    vim.cmd("edit " .. path)
  else
    print("Error: Could not open new notebook file for writing.")
  end
end

vim.api.nvim_create_user_command("NewNotebook", function(opts)
  new_notebook(opts.args)
end, {
  nargs = 1,
  complete = "file",
})
