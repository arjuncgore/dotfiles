-- ~/.config/nvim/lua/config/keymaps.lua
local map = vim.keymap.set

-- ── Telescope ────────────────────────────────────────────────────────────────
map('n', '<leader>ff', function() require('telescope.builtin').find_files() end, { desc = 'Telescope: Find files' })
map('n', '<leader>gf', function() require('telescope.builtin').git_files() end,  { desc = 'Telescope: Git files' })
map('n', '<leader>fg', function()
    require('telescope.builtin').grep_string({ search = vim.fn.input('Grep > ') })
end, { desc = 'Telescope: Grep string' })

-- ── Telescope ────────────────────────────────────────────────────────────────
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle Undotree" })

-- ── Fugitive ────────────────────────────────────────────────────────────────-
vim.keymap.set("n", "<leader>gg", vim.cmd.Git, { desc = "Open Fugitive Git status" })

-- ── Mini.files: global openers ───────────────────────────────────────────────
map('n', '<leader>e', function()
    local mf = require('mini.files')
    if not mf.get_explorer_state() then
        mf.open(vim.uv.cwd(), true)
    else
        mf.close()
    end
end, { desc = 'MiniFiles: Toggle at CWD' })

map('n', '<leader>E', function()
    local mf = require('mini.files')
    local file = vim.api.nvim_buf_get_name(0)
    if file == '' then file = vim.uv.cwd() end
    mf.open(file, true)
end, { desc = 'MiniFiles: Open from current file' })

-- ── Mini.files help popup ───────────────────────────────────────────────────
local mini_files_keymap_help = {
    { "<CR>", "Open" },
    { "t",    "Open in new tab" },
    { "q",    "Close explorer" },
    { "R",    "Refresh" },
    { "a",    "Add file or folder (append / for folder)" },
    { "d",    "Delete file or folder" },
    { "r",    "Rename" },
    { "m",    "Move" },
    { "?",    "Show this help" },
}

local function mini_files_show_help()
    local lines = { "Mini.files Keybindings:", "" }
    for _, item in ipairs(mini_files_keymap_help) do
        table.insert(lines, string.format("  %-5s  %s", item[1], item[2]))
    end
    local width, height = 0, #lines
    for _, line in ipairs(lines) do width = math.max(width, #line) end
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.api.nvim_buf_set_option(buf, "modifiable", false)
    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor", style = "minimal", border = "rounded",
        width = width + 4, height = height + 2,
        row = math.floor((vim.o.lines - height) / 2),
        col = math.floor((vim.o.columns - width) / 2),
    })
    vim.keymap.set("n", "q", function() pcall(vim.api.nvim_win_close, win, true) end,
        { buffer = buf, nowait = true, silent = true, desc = "Close help window" })
end

-- Helpers: current dir & hard reload of current Mini.files view
local function mini_files_current_dir()
    local mf = require("mini.files")
    local state = mf.get_explorer_state()
    if not state then return nil end
    local cur = vim.api.nvim_get_current_win()
    for _, w in ipairs(state.windows or {}) do
        if w.win_id == cur then return w.path end
    end
    return nil
end

local function mini_files_reload_dir()
    local mf = require("mini.files")
    local dir = mini_files_current_dir() or vim.uv.cwd()
    mf.close()
    mf.open(dir, true)
end

-- ── Buffer-local keymaps for Mini.files ──────────────────────────────────────
vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesBufferCreate',
    callback = function(ev)
        local mf  = require('mini.files')
        local buf = ev.data.buf_id
        local function bmap(lhs, rhs, desc)
            map('n', lhs, rhs, { buffer = buf, desc = 'MiniFiles: ' .. desc })
        end
        local function entry() return mf.get_fs_entry() end
        local function is_dir(path)
            local st = vim.uv.fs_stat(path)
            return st and st.type == 'directory'
        end

        -- <CR> : open in place (Mini.files handles dir/file)
        bmap('<CR>', function() mf.go_in() end, 'Open')

        -- t : open in new tab (dir opens Mini.files; file opens buffer)
        bmap('t', function()
            local e = entry(); if not e then return end
            if is_dir(e.path) then
                vim.cmd('tabnew')
                mf.open(e.path, true)
            else
                vim.cmd('tabedit ' .. vim.fn.fnameescape(e.path))
            end
        end, 'Open in new tab')

        -- q : close explorer
        bmap('q', mf.close, 'Close explorer')

        -- R : refresh
        bmap('R', mf.refresh, 'Refresh')

        -- a : add (append "/" to create folder)
        bmap('a', function()
            local dir = mini_files_current_dir() or vim.uv.cwd()
            vim.ui.input({ prompt = 'New (append / for dir): ' }, function(input)
                if not input or input == '' then return end
                local newpath = vim.fs.normalize(dir .. '/' .. input)
                if input:sub(-1) == '/' then
                    vim.fn.mkdir(newpath, 'p')
                else
                    vim.fn.mkdir(vim.fs.dirname(newpath), 'p')
                    vim.fn.writefile({}, newpath)
                end
                mini_files_reload_dir()
            end)
        end, 'Add (file/dir)')

        -- d : delete
        bmap('d', function()
            local e = entry(); if not e then return end
            if vim.fn.confirm('Delete "' .. e.path .. '"?', '&Yes\n&No', 2) ~= 1 then return end
            vim.fn.delete(e.path, 'rf')
            mini_files_reload_dir()
        end, 'Delete')

        -- r : rename
        bmap('r', function()
            local e = entry(); if not e then return end
            vim.ui.input({ prompt = 'Rename to: ', default = vim.fs.basename(e.path) }, function(newname)
                if not newname or newname == '' then return end
                local target = vim.fs.normalize(vim.fs.dirname(e.path) .. '/' .. newname)
                vim.uv.fs_rename(e.path, target)
                mini_files_reload_dir()
            end)
        end, 'Rename')

        -- m : move (dir or full path)
        bmap('m', function()
            local e = entry(); if not e then return end
            local default = (mini_files_current_dir() or vim.uv.cwd()) .. '/' .. vim.fs.basename(e.path)
            vim.ui.input({ prompt = 'Move to (dir or full path): ', default = default }, function(dst)
                if not dst or dst == '' then return end
                local final = dst
                local st = vim.uv.fs_stat(dst)
                if (dst:sub(-1) == '/') or (st and st.type == 'directory') then
                    final = vim.fs.normalize(dst .. '/' .. vim.fs.basename(e.path))
                end
                vim.fn.mkdir(vim.fs.dirname(final), 'p')
                vim.uv.fs_rename(e.path, final)
                mini_files_reload_dir()
            end)
        end, 'Move')

        -- ? : help popup
        bmap('?', mini_files_show_help, 'Show help')
    end,
})

