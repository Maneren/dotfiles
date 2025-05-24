function gitc
    set url $argv[1]
    set --erase argv[1]

    if test -z "$url"
        echo "Usage: gitc <url>"
        return 1
    end

    if string match -q "Maneren/*" "$url" || not string match -q "*/" "$url"
        git clone "git@github.com:Maneren/$(string replace 'Maneren/' '' $url)" $argv
    else if string match -q "ssh:*" "$url"
        git clone "git@github.com:$(string replace 'ssh:' '' $url)" $argv
    else
        git clone "$url" $argv
    end
end
