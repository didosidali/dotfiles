function string_split(my_str)
  local result = {}
  for line in string.gmatch(my_str, "[^\n]+") do
      table.insert(result, line)
  end
  return result
end

vim.api.nvim_create_user_command('Scholar',function()
  pcall(function()
    -- local vstart = vim.fn.getpos("'<")

    -- local vend = vim.fn.getpos("'>")



    -- local line_start = vstart[2]
    -- local line_end = vend[2]

    -- -- or use api.nvim_buf_get_lines
    -- local lines = vim.fn.getline(line_start,line_end)
    -- local lines = get_visual_selection()
    local s_start = vim.fn.getpos("'<")
    local s_end = vim.fn.getpos("'>")

    local n_lines = math.abs(s_end[2] - s_start[2]) + 1
    local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
    lines[1] = string.sub(lines[1], s_start[3], -1)
    if n_lines == 1 then
      lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
    else
      lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
    end
    local new_lines = table.concat(lines, '\n')

    local handle = io.popen("python ~/scripts/scholar.py -c 1 --phrase " .. new_lines .. " --citation bt")
    if (handle == nil) then
      print("scholar no found")
    else
      local result = handle:read("*a")
      handle:close()

      vim.api.nvim_buf_set_lines(s_start[1], s_end[2], s_end[2], false, string_split(result))
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<esc>', true, false, true), 'x', false)

    end
  end)
end,{range = true})
