#!/bin/zsh

# Script to show workspaces 1-5 with current one highlighted in red
# If workspace > 5, just show the number

if pgrep -x "Hyprland" &>/dev/null; then
    # For Hyprland
    current=$(hyprctl activeworkspace -j | jq -r '.id')
elif pgrep -x "niri" &>/dev/null; then
    # For Niri
    current=$(niri msg -j workspaces | jq -r '.[] | select(.is_focused == true) | .idx + 1')
else
    # Fallback
    print "?"
    exit
fi

# If workspace is greater than 5, just show the number in red
if [[ $current -gt 5 ]]; then
    print "<span color='#c1372a'>$current</span>"
else
    # Build the workspace display string for 1-5
    output=""
    for i in {1..5}; do
        if [[ $i -eq $current ]]; then
            output+="<span color='#c1372a'>$i</span>"
        else
            output+="$i"
        fi
        # Add space between numbers except after the last one
        if [[ $i -lt 5 ]]; then
            output+=" "
        fi
    done
    print "$output"
fi
