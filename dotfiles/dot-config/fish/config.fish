# Disable fish greeting
set -U fish_greeting

# Starship
starship init fish | source

# Zoxide
zoxide init fish --cmd cd | source

# Set fish theme
fish_config theme choose "Catppuccin Mocha"

# Enable vi mode
fish_vi_key_bindings
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_replace underscore
set fish_cursor_external line
