-- 1. Definisikan fungsi (sama seperti sebelumnya)
Bottom_win = nil
Bottom_buf = nil

function Open_bottom_doc(entry)
	print("DEBUG: open_bottom_doc dipicu")

	if not entry then
		print("DEBUG: Entry kosong!")
		return
	end

	-- Get Doc
	local documentation = entry:get_documentation()
	if not documentation or #documentation == 0 then
		if Bottom_win and vim.api.nvim_win_is_valid(Bottom_win) then
			vim.api.nvim_win_close(Bottom_win, true)
		end
		print("DEBUG: Lah kok!")
		return
	end

	-- Setup Dimensi
	local ui = vim.api.nvim_list_uis()[1] -- Ambil UI pertama yang aktif
	local width = ui.width
	local height = ui.height
	local win_height = 5
	local row_pos = height - (win_height + 3) -- Sesuaikan jika menabrak

	-- Create or Reuse buffer
	if not Bottom_buf or not vim.api.nvim_buf_is_valid(Bottom_buf) then
		Bottom_buf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_buf_set_lines(Bottom_buf, 0, -1, false, documentation)
	end

	if not Bottom_win or not vim.api.nvim_win_is_valid(Bottom_win) then
		local win_opts = {
			relative = "editor",
			width = width,
			height = win_height,
			row = row_pos,
			col = 0,
			style = "minimal",
			border = "single",
			focusable = false,
		}

		Bottom_win = vim.api.nvim_open_win(Bottom_buf, true, win_opts)
	else
		vim.api.nvim_win_set_config(Bottom_win, { width = width, row = row_pos, col = 0 })
	end
end
