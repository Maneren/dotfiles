local wezterm = require("wezterm")

local function get_cursor_theme()
	local success, stdout, stderr = wezterm.run_child_process({ "xprop", "-root" })
	if not success then
		wezterm.log_error(("Command exited with non-zero exit code.\nStdout:\n%s\nStderr:\n%s"):format(stdout, stderr))
		return nil
	end

	return stdout:match([[RESOURCE_MANAGER%(STRING%) = ".+\nXcursor.theme:\t([^\\]+)\n.+"]])
end

-- has to be a function, to spawn the child process in main thread
return function()
	return {
		xcursor_theme = get_cursor_theme(),
	}
end
