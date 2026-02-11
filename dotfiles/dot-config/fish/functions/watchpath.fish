function watchpath --description "Watch paths for changes and execute callback"
    set -l targets
    set -l callback
    set -l target_event
    set -l parsing_targets false

    # Parse arguments
    for arg in $argv
        if test "$parsing_targets" = true
            set -a targets $arg
        else if test "$arg" = --
            set parsing_targets true
        else if test -z "$callback"
            set callback $arg
        else
            set target_event $arg
        end
    end

    # Validate inputs
    if test (count $targets) -eq 0
        echo "Usage: watchpath [callback] [event] -- <targets>"
        return 1
    end

    # Set defaults
    if test -z "$callback"
        set callback 'echo $file: $event'
    end

    if test -z "$target_event"
        set target_event "-e modify"
    else if test "$target_event" = all
        set target_event ""
    else if not string match -q -- '-e*' "$target_event"
        set target_event "-e $target_event"
    end

    set -l event
    set -l file

    # Main loop
    while true
        # Build inotifywait command
        set -l cmd inotifywait -rq
        if test -n "$target_event"
            set -a cmd (string split ' ' -- $target_event)
        end
        set -a cmd $targets

        # Execute inotifywait and capture output
        set -l output ($cmd)
        set -l exit_code $status

        if test $exit_code -ne 0
            echo "inotifywait failed"
            return 2
        end

        # Parse output
        set -l parts (string split ' ' -- $output)
        set -l folder $parts[1]
        set event $parts[2]
        set -l name $parts[3]

        # Construct file path
        if test -n "$folder"
            set file "$folder$name"
        else
            set file $folder
        end

        # Use fish's variable substitution for the callback
        set -l expanded_callback (string replace -a '$file' $file -- $callback)
        set expanded_callback (string replace -a '$event' $event -- $expanded_callback)

        # Execute callback
        echo "\$ $expanded_callback"
        eval $expanded_callback
        set exit_code $status
    end
end
