local ok, wk = pcall(require, "which-key")
if not ok then
  return
end

wk.setup {
  plugins = {
    marks = true,
    registers = true,
    spelling = { enabled = true, suggestions = 20 },
    presets = {
      operators = true,
      motions = true,
      text_objects = true,
      windows = true,
      nav = true,
      z = true,
      g = true,
    },
  },
  window = {
    border = "rounded",
    position = "bottom",
  },
  layout = {
    align = "center",
  },
}
