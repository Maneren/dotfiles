function ikill
    set -l pid (ps aux | fzf -m | awk '{print $2}')
    if test -n "$pid"
        kill -9 $pid
    else
        echo "No process selected"
    end
end
