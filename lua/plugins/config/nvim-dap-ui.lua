return function()
  vim.cmd([[vnoremap <c-;> <Cmd>lua require("dapui").eval()<CR>]])
end
