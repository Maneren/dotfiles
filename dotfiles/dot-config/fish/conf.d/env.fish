set -g EDITOR nvim
set -g SELECTED_EDITOR $EDITOR
set -g PAGER less
set -g MOAR "--statusbar=bold --mousemode=scroll"
set -g MANPAGER 'nvim +Man!'

# by default run make in parallel mode
set -g MAKEFLAGS "-j (grep -c '^processor' /proc/cpuinfo)"

set -g TIMEFMT "\n================\nCPU\t%P\nuser\t%*U\nsystem\t%*S\ntotal\t%*E\nmemory\t%MMB\n================\n"

set -g DOTNET_CLI_TELEMETRY_OPTOUT 1

set -U FISH_THEME "Catppuccin Mocha"
