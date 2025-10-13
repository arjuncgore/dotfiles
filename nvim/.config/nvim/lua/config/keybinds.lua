vim.g.mapleader = " "
vim.keymap.set("n", "<leader>e", vim.cmd.Oil, { desc = "Oil" } )

vim.keymap.set({ "n", "t" }, "<leader>t", function()
  local term_buf = nil
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buftype == "terminal" then
      term_buf = buf
      break
    end
  end

  if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
    vim.cmd("bd! " .. term_buf)         -- close terminal if open
  else
    vim.cmd("terminal")                 -- open terminal
    vim.cmd("startinsert")              -- jump straight into insert (terminal) mode
  end
end, { desc = "Toggle Terminal" })

