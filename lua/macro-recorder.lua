local select_macro = function()
  local Input = require("nui.input")
  local event = require("nui.utils.autocmd").event

  local input = Input({
    position = "90%",
    size = {
      width = 10,
    },
    border = {
      style = "rounded",
      text = {
        top = "[macro]",
        top_align = "left",
      },
    },
  }, {
    prompt = "☣︎ ",
    on_close = function() end,
    on_submit = function(value)
      vim.g.repetable_macro = string.sub(value, 1, 1)
    end,
  })

  input:mount()

  input:on(event.BufLeave, function()
    input:unmount()
  end)

  input:map("n", "<esc>", function()
    input:unmount()
  end)
end

local repetable_macro = function()
  vim.cmd("@" .. (vim.g.repetable_macro or "_"))
end

return {
  select_macro = select_macro,
  repetable_macro = repetable_macro,
}
