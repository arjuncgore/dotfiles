return {
  {
    "mbbill/undotree",
    config = function()
      -- Optional: better layout
      vim.g.undotree_WindowLayout = 2       -- 2 = tree on the right, diff below
      vim.g.undotree_SplitWidth = 35
      vim.g.undotree_DiffpanelHeight = 10
      vim.g.undotree_SetFocusWhenToggle = true
    end,
  },
}

