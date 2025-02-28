return {
  { -- directly open ipynb files as quarto docuements
    -- and convert back behind the scenes
    "GCBallesteros/jupytext.nvim",
    -- style = "markdown",
    -- output_extension = "md",
    -- force_ft = "markdown",
    opts = {
      custom_language_formatting = {
        python = {
          extension = "md",
          style = "markdown",
          force_ft = "markdown",
        },
        r = {
          extension = "qmd",
          style = "quarto",
          force_ft = "quarto",
        },
      },
    },
  },
}
