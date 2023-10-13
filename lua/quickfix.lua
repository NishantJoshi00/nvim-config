

--[[ 
--
-- How to use quickfix list? search only
--
-- gr [pattern] . -R to search for a pattern
--
-- cope to open the quickfix list
--
-- ]]

local rust_quickfix = function ()
  vim.cmd[[set efm=%Eerror\[%*[0-9E]\]:\ %m,%C\ \ \ \ -->\ %f:%l:%c,%Z]]
end


return {
  rust_quickfix = rust_quickfix
}
