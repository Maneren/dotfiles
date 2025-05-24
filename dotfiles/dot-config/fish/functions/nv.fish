function nv
    set target $argv[1]
    set --erase argv[1]

    if test -f "$target"
        set work_dir (dirname "$target")
        set target (basename "$target")
    else
        set work_dir "$target"
        set target ""
    end

    pushd "$work_dir"
    neovide "$target" $argv
    popd
end
