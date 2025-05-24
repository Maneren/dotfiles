function backup
    set D (date +"%Y-%m-%d-%H-%M")
    for file in $argv
        cp -r "$file" "$file.T.$D.bak"
        echo "copied '$file' to '$file.T.$D.bak'"
    end
end
