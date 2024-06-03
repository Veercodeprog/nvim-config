return {

 "lukas-reineke/indent-blankline.nvim",
event = {"BufRead", "BufNewFile"},
main = "ibl",
    opts = {
  indent = { char = "┊" },
    },
}
