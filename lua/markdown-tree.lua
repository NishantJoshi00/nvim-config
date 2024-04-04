local n = require("nui-components")

---@param content string
function convert_checklist(content)
  -- the pattern as regex is `^(\s*)- \[(x| )\] (.*)$`
  -- local pattern = "^%s*%-%s*%[(x| )](.*)$"
  local pattern = "^(%s*)%-%s*%[%s*(x?)%](.*)$"

  local lines = vim.split(content, "\n")
  local nodes = {}
  for i, line in ipairs(lines) do
    local space, xs, msg = string.match(line, pattern)
    if (space) then
      table.insert(nodes, {
        text = msg,
        is_done = xs == "x",
        depth = #space
      })
    end
  end
  local base_space = nodes[1].depth

  local tree = make_children(nodes)
  nodes = {}

  for i, node in ipairs(tree) do
    table.insert(nodes, n.node({ text = node.text, is_done = node.is_done }, node.children))
  end


  return n.tree({
    autofocus = true,
    data = nodes,
    on_select = function(node, component)
      local ntree = component:get_tree()
      node.is_done = not node.is_done
      ntree:render()
    end,
    prepare_node = function(node, line, component)
      if node.is_done then
        line:append("✔", "String")
      else
        line:append("◻", "Comment")
      end
      line:append(" ")
      line:append(node.text)

      return line
    end,
  })
end

---@param nodes table
function make_children(nodes)
  if (#nodes == 0) then
    return {}
  end
  local current_space = nodes[1].depth
  local this_level = {}
  local children = {}

  while #nodes > 0 do
    local node = table.remove(nodes, 1)
    if node.depth == current_space then
      if #this_level > 0 then
        this_level[#this_level].children = make_children(children)
        children = {}
      end
      table.insert(this_level, { text = node.text, is_done = node.is_done })
    else
      table.insert(children, node)
    end
  end


  if #this_level > 0 then
    this_level[#this_level].children = make_children(children)
    children = {}
  end

  return this_level
end

local data = [[- [ ] Hello World]]

function test()
  local renderer = n.create_renderer({
    width = 80,
    height = 40,
  })

  local body = function()
    return convert_checklist(data)
  end

  renderer:add_mappings({
    {
      mode = { "n", "i" },
      from = "<leader>c",
      to = function()
        renderer:close()
      end,
    },
  })

  renderer:on_unmount(function()
  end)

  renderer:render(body)
end

test()
