-- Initialize random seed once at module load time with better entropy
math.randomseed(os.time() + vim.fn.getpid())

---Create a Nui.input with standard configuration
---@param title string The title to display
---@param on_submit function Callback when user submits input
---@param opts table|nil Optional configuration (position, size, width)
---@return table input The created input object
local create_nui_input = function(title, on_submit, opts)
    opts = opts or {}
    local Input = require("nui.input")
    local event = require("nui.utils.autocmd").event

    local input = Input({
        position = opts.position or { row = "50%", col = "50%" },
        size = opts.size or { width = opts.width or 80 },
        border = {
            style = "rounded",
            text = {
                top = "[" .. title .. "]",
                top_align = "center",
            },
        },
        win_options = {
            winhighlight = "Normal:Normal,FloatBorder:Normal",
        },
    }, {
        prompt = "% ",
        on_close = function() end,
        on_submit = on_submit,
    })

    input:mount()

    -- Setup standard exit behavior
    local exit_action = function()
        input:unmount()
    end
    input:on(event.BufLeave, exit_action)
    input:map("n", "<esc>", exit_action)

    return input
end

---Check if the system is disabled
---
---@param systems string[]
---@return boolean
local disabled_on = function(systems)
    for _, val in ipairs(systems) do
        if vim.fn.has(val) == 1 then
            return true
        end
    end
    return false
end

---Get a random quote - and display it in a vim.notify
---
local quoter = function()
    vim.fn.jobstart("curl -s --max-time 5 https://zenquotes.io/api/random | jq '.[0][\"q\"]'", {
        stdout_buffered = true,
        on_stdout = function(a, b, c)
            -- print(vim.inspect(b))
            vim.notify(b[1], "info", { hide_from_history = true })
        end,
        on_stderr = function(_, data, _)
            if data and #data > 0 and data[1] ~= "" then
                vim.notify("Failed to fetch quote: " .. table.concat(data, "\n"), vim.log.levels.WARN)
            end
        end,
    })
end

---Get a random footer for the dashboard
---
---@return string
local random_footer = function()
    local footers = {
        "🚀 Sharp tools make good work.",
        "🥛 Boost is the secret of my energy.",
        "🥛 I am a complan boy",
        "⛰  Washing powder nirma",
        "📜 Luck is the planning, that you don't see.",
        "💣 Every problem is a business opportunity.",
        "💡 Typo? Or a happy little accident?",
        "🐍 import antigravity",
        "🧠 RAM is temporary, Vim is eternal.",
        "🤖 Copilot’s on vacation, you’re on your own.",
        "🔍 Grep it like it’s hot.",
        "🌀 You either die in VSCode, or live long enough to become a Vim user.",
        "🪄 :wq — and just like that, it’s gone.",
        "👻 Ghost of bugs past still haunts this screen.",
        "🎯 Ship it. Regret later.",
        "🍜 Code, slurp, repeat.",
        "🧘 Zen mode. Because chaos needs boundaries.",
        "🌌 The universe compiles... eventually.",
        "🔧 If it compiles, ship it.",
        "🔥 That wasn’t a bug. It was undocumented brilliance.",
        "💡 At day’s end, it’s all ideas in binary.",
        "🧙 Any sufficiently advanced bug is indistinguishable from a feature.",
        "🎯 Precision is overrated. Ship it.",
        "🎪 Production is just staging with consequences.",
        "🍕 Code is poetry. Bugs are free verse.",
        "🧙‍♂️ sudo make me a sandwich.",
        "🎲 Move fast. Break things. Blame cache.",
        "🧦 Life is too short for matching socks.",
        "🎯 Have you tried turning your life off and on again?",
        "💡 Tip: Deleting bugs makes your code have fewer bugs.",
        "⚡ Tip: Pressing i won't work here, this is a loading screen.",
        "⚛️ Tip: In another universe, this tip is a bug report about itself.",
        "🕳️ This escaped random() to find you."
    }
    return footers[math.random(1, #footers)]
end

local get_newline = function()
    if vim.fn.has("win32") == 1 then
        return "\r\n"
    else
        return "\n"
    end
end

local theme_choicer = function()
    local Menu = require("nui.menu")
    local event = require("nui.utils.autocmd").event

    local lines = {}

    for i in pairs(vim.g.theme_choices) do
        table.insert(lines, Menu.item(vim.g.theme_choices[i]))
    end

    local menu = Menu({
        position = "50%",
        size = {
            width = 40,
        },
        border = {
            style = "rounded",
            text = {
                top = "[theme select]",
                top_align = "center",
            },
        },
        win_options = {
            winhighlight = "Normal:Normal,FloatBorder:Normal",
        },
    }, {
        lines = lines,
        on_close = function() end,
        on_submit = function(item)
            vim.cmd(item.text)
        end
    });

    menu:on(event.BufLeave, function()
        menu:unmount()
    end)

    menu:map("n", "<esc>", function()
        menu:unmount()
    end)

    menu:mount()
end

---Navigate to a file:line:col location with proper error handling
---@param data string The path string in format "file:line:col"
local point_search_inner = function(data)
    local regex = "%s*([A-Za-z0-9/._-]+):?(%d*):?(%d*)%s*$"
    local file_path, line_no, col_no = string.match(data, regex)

    -- Validate file path exists
    if not file_path then
        vim.notify("Invalid file path format", vim.log.levels.WARN)
        return
    end

    -- Check if file is readable
    if vim.fn.filereadable(file_path) == 0 then
        vim.notify("File not found: " .. file_path, vim.log.levels.WARN)
        return
    end

    -- Safely open file with escaped path
    local escaped_path = vim.fn.fnameescape(file_path)
    local success, err = pcall(vim.cmd, "edit " .. escaped_path)
    if not success then
        vim.notify("Failed to open file: " .. tostring(err), vim.log.levels.ERROR)
        return
    end

    -- Convert line and column numbers with proper defaults
    line_no = tonumber(line_no) or 0
    col_no = tonumber(col_no) or 0

    -- Move cursor if valid line number
    if line_no > 0 then
        vim.api.nvim_win_set_cursor(0, {line_no, col_no})
    end
end

---Open point search input dialog
local point_search = function()
    create_nui_input("point search", point_search_inner, {
        position = { row = "20%", col = "50%" },
        width = 80
    })
end

-- Module-scoped state (instead of vim.g globals)
local copy_pad_state = {
    open = {},
    content = {}
}

---Create a Nui popup with standard configuration
---@param name string The name/title of the popup
---@return table popup The created popup object
local create_copy_pad_popup = function(name)
    local Popup = require("nui.popup")

    local popup = Popup({
        enter = true,
        focusable = true,
        border = {
            style = "rounded",
            text = {
                bottom = name,
                bottom_align = "center",
            },
            padding = { 1, 1 },
        },
        position = {
            row = "50%",
            col = "100%",
        },
        size = "40%",
    })

    return popup
end

---Setup popup buffer with initial content and syntax
---@param popup table The popup object
---@param name string The name of the pad
local setup_popup_content = function(popup, name)
    if copy_pad_state.content[name] then
        vim.api.nvim_buf_set_lines(popup.bufnr, 0, -1, false, copy_pad_state.content[name])
    end
    vim.api.nvim_buf_set_option(popup.bufnr, "syntax", "markdown")
end

---Create exit handler that saves content and unmounts popup
---@param popup table The popup object
---@param name string The name of the pad
---@param callback function Callback to execute with content
---@return function exit_handler The exit handler function
local create_exit_handler = function(popup, name, callback)
    return function()
        local lines = vim.api.nvim_buf_get_lines(popup.bufnr, 0, -1, false)
        copy_pad_state.content[name] = lines

        local content = table.concat(lines, get_newline())
        callback(content, name, lines)

        popup:unmount()
        copy_pad_state.open[name] = false
    end
end

---Open a copy/scratch pad with Nui popup
---@param name string The name of the pad
---@param callback function Callback to execute when pad closes
---@param init function|nil Optional initialization function
local nui_copy_pad = function(name, callback, init)
    -- Initialize content if needed
    if init ~= nil and copy_pad_state.content[name] == nil then
        copy_pad_state.content[name] = init()
    end

    -- Prevent opening multiple times
    if copy_pad_state.open[name] then
        return
    end

    -- Create and mount popup
    local popup = create_copy_pad_popup(name)
    popup:mount()

    -- Setup content and mark as open
    setup_popup_content(popup, name)
    copy_pad_state.open[name] = true

    -- Create and bind exit handler
    local event = require("nui.utils.autocmd").event
    local exit_action = create_exit_handler(popup, name, callback)

    popup:on(event.BufLeave, exit_action)
    popup:map("n", "<esc>", exit_action)
    popup:map("n", ":", exit_action)
end

local get_current_location = function(callback)
    local filename = vim.fn.expand("%:.")
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))

    callback(filename .. ":" .. row .. ":" .. col)
end


local telescope_theme = function(opts)
    return require("telescope.themes").get_ivy(opts)
    -- return opts
end


---Open glob search input dialog for Telescope
local glob_search = function()
    create_nui_input("glob_search", function(value)
        require("telescope.builtin").live_grep(telescope_theme({
            glob_pattern = value,
        }))
    end, {
        position = { row = "90%", col = "50%" },
        width = 40
    })
end

return {
    disabled_on = disabled_on,
    quoter = quoter,
    dashboard_footer = random_footer,
    copy_pad = nui_copy_pad,
    point_search = point_search,
    get_current_location = get_current_location,
    glob_search = glob_search,
    telescope_theme = telescope_theme,
    theme_choicer = theme_choicer
}
