
#!/bin/bash

typewriter() {
    local text="$1"
    local i=0
    while [ $i -lt ${#text} ]; do
        char="${text:$i:1}"
        if [ "$char" == " " ]; then
            echo -n " "  # Preserve spaces
        else
            echo -n "$char"
        fi
        sleep 0.0025  # Speed adjustment
        ((i++))
    done
    echo  # New line at the end
}

