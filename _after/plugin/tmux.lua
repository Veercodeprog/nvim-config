local M = {}

-- Set prefix key to Ctrl-a
M.prefix_key = '<C-a>'

-- Split panes
M.split_horizontal = M.prefix_key .. 'h'
M.split_vertical = M.prefix_key .. 'v'

-- Switch panes
M.switch_up = M.prefix_key .. 'k'
M.switch_down = M.prefix_key .. 'j'
M.switch_left = M.prefix_key .. 'h'
M.switch_right = M.prefix_key .. 'l'

-- Resize panes
M.resize_up = M.prefix_key .. '<Up>'
M.resize_down = M.prefix_key .. '<Down>'
M.resize_left = M.prefix_key .. '<Left>'
M.resize_right = M.prefix_key .. '<Right>'

-- Customize other tmux settings
M.other_setting = 'value'

return M

