set -q XDG_CONFIG_HOME; or set -Ux XDG_CONFIG_HOME $HOME/.config
set -q XDG_DATA_HOME; or set -Ux XDG_DATA_HOME $HOME/.local/share
set -q XDG_STATE_HOME; or set -Ux XDG_STATE_HOME $HOME/.local/state
set -q XDG_CACHE_HOME; or set -Ux XDG_CACHE_HOME $HOME/.cache

for xdgdir in (path filter -vd $XDG_CONFIG_HOME $XDG_DATA_HOME $XDG_STATE_HOME $XDG_CACHE_HOME)
    mkdir -p $xdgdir
end

# Allow subdirs for functions and completions.
set fish_function_path (path resolve $__fish_config_dir/functions/*/) $fish_function_path
set fish_complete_path (path resolve $__fish_config_dir/completions/*/) $fish_complete_path

set -g ANDROID_HOME "$XDG_DATA_HOME/android/sdk"
set -g CARGO_HOME "$XDG_DATA_HOME/cargo"
set -g CUDA_CACHE_PATH "$XDG_CACHE_HOME/nv"
set -g DOCKER_CONFIG "$XDG_CONFIG_HOME/docker"
set -g DOTNET_CLI_HOME "$XDG_DATA_HOME/dotnet"
set -g GHCUP_USE_XDG_DIRS true
set -g GNUPGHOME "$XDG_DATA_HOME/gnupg"
set -g GOPATH "$XDG_DATA_HOME/go"
set -g GTK2_RC_FILES "$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
set -g IPYTHONDIR "$XDG_CONFIG_HOME/ipython"
set -g KDEHOME "$XDG_CONFIG_HOME/kde"
set -g NDK_HOME "$ANDROID_HOME/ndk/27.0.12077973"
set -g NODE_REPL_HISTORY "$XDG_CACHE_HOME/.node_repl_history"
set -g NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npm/npmrc"
set -g NUGET_PACKAGES "$XDG_CACHE_HOME/NuGetPackages"
set -g OMNISHARPHOME "$XDG_CONFIG_HOME/omnisharp"
set -g PLATFORMIO_CORE_DIR "$XDG_DATA_HOME/platformio"
set -g PNPM_HOME "$XDG_DATA_HOME/pnpm"
set -g PYTHONHISTFILE "$XDG_CACHE_HOME/.python_history"
set -g RUSTUP_HOME "$XDG_DATA_HOME/rustup"
set -g STACK_XDG 1
set -g W3M_DIR "$XDG_DATA_HOME/w3m"
set -g WAKATIME_HOME "$XDG_CONFIG_HOME/wakatime"
set -g WASMTIME_HOME "$XDG_DATA_HOME/wasmtime"
set -g WINEPREFIX "$XDG_DATA_HOME/wine"
set -g XCURSOR_PATH /usr/share/icons:"$XDG_DATA_HOME/icons"

# use global target folder for cargo
set -g CARGO_TARGET_DIR "$XDG_CACHE_HOME/cargo/target"

set -g CC clang
set -g CXX clang++

# Fisher
init_fisher

# Add bin directories to path.
set -g prepath (
    path filter \
      "$HOME/.local/bin" \
      "$HOME/.cabal/bin" \
      "$HOME/.ghcup/bin" \
      "$HOME/.local/share/bob/nvim-bin" \
      "$CARGO_HOME/bin" \
      "$GOPATH/bin" \
      "$PNPM_HOME" \
      "$WASMTIME_HOME" \
      "$HOME/.local/share/nvim/mason/bin" \
)
fish_add_path --prepend --move $prepath
