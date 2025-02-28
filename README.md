# 💤 LazyVim Configs 
My nvim folder with plugins from [LazyVim](https://github.com/LazyVim/LazyVim).

Refer to the [documentation](https://lazyvim.github.io/installation) to get started with neovim/LazyVim.

to use this do:
```bash
git clone https://github.com/TanmayPani/my-nvim-folder.git ~/.config/nvim
```

## Caveats
This is in a very rudimentary stage, if you decide to use this, everything might not work out of box.

If you want something more finished, check out [quarto-nvim-kickstarter](https://github.com/jmbuhr/quarto-nvim-kickstarter). This looks especially good for python devs.

# To-dos
1. Molten (jupyter notebook emulator) command keymaps dont work
2. Kernels not automatically loaded. You have to activate a kernel in your shell before using something like `conda activate <env-name>` or `source <venv-prefix>/bin/activate` before entering editor using `nvim` to use python notebook related features from plugins like Molten or Quarto
3. LaTeX treesitter parsing doesnt work (Tho that could be an issue with my treesitter/treesitter-cli installation too)
4. Add more detailed specificatons and options enabled in each plugin used.

I will be getting to these in the coming weeks, check back here if you end up using this and 
1. Let me know if you figure these out and I havent updated the repo (through issues, maybe?), OR
2. Reap the rewards if I have figured it out and updated the repo
   
