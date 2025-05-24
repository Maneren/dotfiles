function bk
    for file in $argv
        cp -r "$file" "$file.bak"
    end
end
