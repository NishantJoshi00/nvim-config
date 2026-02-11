math.randomseed(os.time() + vim.fn.getpid())

---@param title string
---@param on_submit function
---@param opts table|nil
local function create_nui_input(title, on_submit, opts)
    opts = opts or {}
    local Input = require("nui.input")
    local event = require("nui.utils.autocmd").event

    local input = Input({
        position = opts.position or { row = "50%", col = "50%" },
        size = opts.size or { width = opts.width or 80 },
        border = {
            style = "rounded",
            text = { top = "[" .. title .. "]", top_align = "center" },
        },
        win_options = {
            winhighlight = "Normal:Normal,FloatBorder:Normal",
        },
    }, {
        prompt = "% ",
        on_submit = on_submit,
    })

    input:mount()

    local function exit() input:unmount() end
    input:on(event.BufLeave, exit)
    input:map("n", "<esc>", exit)

    return input
end

---@param systems string[]
---@return boolean
local function disabled_on(systems)
    for _, val in ipairs(systems) do
        if vim.fn.has(val) == 1 then
            return true
        end
    end
    return false
end

local quote_job_id = nil

local function quoter()
    if quote_job_id and vim.fn.jobwait({ quote_job_id }, 0)[1] == -1 then
        vim.fn.jobstop(quote_job_id)
    end

    quote_job_id = vim.fn.jobstart("curl -s --max-time 5 https://zenquotes.io/api/random | jq '.[0][\"q\"]'", {
        stdout_buffered = true,
        on_exit = function() quote_job_id = nil end,
        on_stdout = function(_, data)
            if data and data[1] and data[1] ~= "" then
                vim.schedule(function()
                    vim.notify(data[1], "info", { hide_from_history = true })
                end)
            end
        end,
        on_stderr = function(_, data)
            if data and data[1] and data[1] ~= "" then
                vim.schedule(function()
                    vim.notify("Failed to fetch quote: " .. table.concat(data, "\n"), vim.log.levels.WARN)
                end)
            end
        end,
    })
end

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
    "🤖 Copilot's on vacation, you're on your own.",
    "🔍 Grep it like it's hot.",
    "🌀 You either die in VSCode, or live long enough to become a Vim user.",
    "🪄 :wq — and just like that, it's gone.",
    "👻 Ghost of bugs past still haunts this screen.",
    "🎯 Ship it. Regret later.",
    "🍜 Code, slurp, repeat.",
    "🧘 Zen mode. Because chaos needs boundaries.",
    "🌌 The universe compiles... eventually.",
    "🔧 If it compiles, ship it.",
    "🔥 That wasn't a bug. It was undocumented brilliance.",
    "💡 At day's end, it's all ideas in binary.",
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
    "🕳️ This escaped random() to find you.",
}

---@param data string
local function point_search_inner(data)
    local file_path, line_no, col_no = data:match("%s*([A-Za-z0-9/._-]+):?(%d*):?(%d*)%s*$")

    if not file_path then
        vim.notify("Invalid file path format", vim.log.levels.WARN)
        return
    end

    if vim.fn.filereadable(file_path) == 0 then
        vim.notify("File not found: " .. file_path, vim.log.levels.WARN)
        return
    end

    local ok, err = pcall(vim.cmd, "edit " .. vim.fn.fnameescape(file_path))
    if not ok then
        vim.notify("Failed to open file: " .. tostring(err), vim.log.levels.ERROR)
        return
    end

    line_no = tonumber(line_no) or 0
    col_no = tonumber(col_no) or 0
    if line_no > 0 then
        vim.api.nvim_win_set_cursor(0, { line_no, col_no })
    end
end

local copy_pad_state = { open = {}, content = {} }

local newline = vim.fn.has("win32") == 1 and "\r\n" or "\n"

---@param name string
---@param callback function
---@param init function|nil
local function nui_copy_pad(name, callback, init)
    if init and not copy_pad_state.content[name] then
        copy_pad_state.content[name] = init()
    end

    if copy_pad_state.open[name] then return end

    local Popup = require("nui.popup")
    local event = require("nui.utils.autocmd").event

    local popup = Popup({
        enter = true,
        focusable = true,
        border = {
            style = "rounded",
            text = { bottom = name, bottom_align = "center" },
            padding = { 1, 1 },
        },
        position = { row = "50%", col = "100%" },
        size = "40%",
    })

    popup:mount()

    if copy_pad_state.content[name] then
        vim.api.nvim_buf_set_lines(popup.bufnr, 0, -1, false, copy_pad_state.content[name])
    end
    vim.api.nvim_set_option_value("syntax", "markdown", { buf = popup.bufnr })
    copy_pad_state.open[name] = true

    local function exit()
        local lines = vim.api.nvim_buf_get_lines(popup.bufnr, 0, -1, false)
        copy_pad_state.content[name] = lines
        callback(table.concat(lines, newline), name, lines)
        popup:unmount()
        copy_pad_state.open[name] = false
    end

    popup:on(event.BufLeave, exit)
    popup:map("n", "<esc>", exit)
    popup:map("n", ":", exit)
end

local function telescope_theme(opts)
    return require("telescope.themes").get_ivy(opts)
end

local function glob_search()
    create_nui_input("glob_search", function(value)
        require("telescope.builtin").live_grep(telescope_theme({
            glob_pattern = value,
        }))
    end, {
        position = { row = "90%", col = "50%" },
        width = 40,
    })
end

return {
    disabled_on = disabled_on,
    quoter = quoter,
    dashboard_footer = function() return footers[math.random(#footers)] end,
    copy_pad = nui_copy_pad,
    point_search = function()
        create_nui_input("point search", point_search_inner, {
            position = { row = "20%", col = "50%" },
            width = 80,
        })
    end,
    get_current_location = function(callback)
        local filename = vim.fn.expand("%:.")
        local row, col = unpack(vim.api.nvim_win_get_cursor(0))
        callback(filename .. ":" .. row .. ":" .. col)
    end,
    glob_search = glob_search,
    telescope_theme = telescope_theme,
}
