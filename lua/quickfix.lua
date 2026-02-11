-- Quickfix format patterns
-- Usage: gr [pattern] . -R to search, :cope to open quickfix list

local formats = {
  rust = [[%Eerror\[%*[0-9E]\]:\ %m,%C\ \ \ \ -->\ %f:%l:%c,%Z]],
  python = [[%E\ %m,%C\ \ \ \ -->\ %f:%l:%c,%Z]],
}

local function rust_quickfix()
  vim.o.errorformat = formats.rust
end

return { rust_quickfix = rust_quickfix }
