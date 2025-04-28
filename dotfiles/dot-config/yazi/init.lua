require("augment-command"):setup({
	prompt = false,
	default_item_group_for_prompt = "hovered",
	smart_enter = true,
	smart_paste = false,
	smart_tab_create = false,
	smart_tab_switch = true,
	open_file_after_creation = false,
	enter_directory_after_creation = false,
	use_default_create_behaviour = false,
	enter_archives = true,
	extract_retries = 3,
	recursively_extract_archives = true,
	preserve_file_permissions = true,
	must_have_hovered_item = true,
	skip_single_subdirectory_on_enter = true,
	skip_single_subdirectory_on_leave = false,
	wraparound_file_navigation = true,
})

Header:children_add(function()
	if ya.target_family() ~= "unix" then
		return ui.Line({})
	end
	return ui.Span(ya.user_name() .. "@" .. ya.host_name() .. ":"):fg("blue")
end, 500, Header.LEFT)

require("archivemount"):setup()
require("git"):setup()

require("yaziline"):setup({
	separator_open = "",
	separator_close = "",
	separator_open_thin = "",
	separator_close_thin = "",
	select_symbol = "",
	yank_symbol = "󰆐",
})
